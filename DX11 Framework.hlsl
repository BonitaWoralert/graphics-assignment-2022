//--------------------------------------------------------------------------------------
// File: DX11 Framework.hlsl
//
// Copyright (c) Microsoft Corporation. All rights reserved.
//--------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------
// Constant Buffer Variables
//--------------------------------------------------------------------------------------
cbuffer ConstantBuffer : register( b0 )
{
	matrix World;
	matrix View;
	matrix Projection;
 
    float4 DiffuseLight;
    float4 DiffuseMaterial;
    float3 DirectionToLight;
    float pad;
    float4 AmbientLight;
    float4 AmbientMaterial;
    float4 SpecularMaterial;
    float4 SpecularLight;
    float SpecularPower;
    float3 EyeWorldPos;
}

//--------------------------------------------------------------------------------------
struct VS_OUTPUT
{
    float4 Pos : SV_POSITION;
    float4 Color : COLOR0;
    float3 PosW : POSITION0;
    float3 NormalW : NORMAL0;
    
};

//--------------------------------------------------------------------------------------
// Vertex Shader
//--------------------------------------------------------------------------------------
VS_OUTPUT VS( float3 Pos : POSITION, float3 Normal : NORMAL )
{
    float4 pos4 = float4(Pos, 1.0f);
    float4 Normal4 = float4(Normal, 0.0f);
    //AmbientMaterial = float4(1.0f, 0.0f, 0.0f, 1.0f);
    //AmbientLight = float4(0.2f, 0.2f, 0.2f, 0.2f);
    
    VS_OUTPUT output = (VS_OUTPUT)0;
    output.Pos = mul( pos4, World);
    output.PosW = output.Pos;
    output.NormalW = normalize(mul(Normal4, World));
    output.Pos = mul( output.Pos, View );
    output.Pos = mul( output.Pos, Projection );
    
    return output;
}


//--------------------------------------------------------------------------------------
// Pixel Shader
//--------------------------------------------------------------------------------------
float4 PS( VS_OUTPUT input ) : SV_Target
{
    //Diffuse Light calculations
    float DiffuseAmount = max(dot(normalize(DirectionToLight), input.NormalW), 0);
    float4 Diffuse = DiffuseAmount * (DiffuseMaterial * DiffuseLight);
    
    //Ambient Light calculations
    float4 Ambient = AmbientLight * AmbientMaterial;
    
    //Specular Light calculations
    float3 ReflectDir = reflect(DirectionToLight, input.NormalW);
    float pad;
    float3 ViewerDir = normalize(input.PosW.xyz - EyeWorldPos);
    float SpecIntensity = max(dot(ReflectDir, ViewerDir), 0);
    pow(SpecIntensity, SpecularPower);
    float4 SpecPotential = SpecularLight * SpecularMaterial;
    float4 Specular = SpecIntensity * SpecPotential;
    
    //final colour
    //input.Color = Diffuse;
    //input.Color = Ambient;
    //input.Color = Specular;
    input.Color = Specular + Diffuse + Ambient;
    return input.Color;
}
