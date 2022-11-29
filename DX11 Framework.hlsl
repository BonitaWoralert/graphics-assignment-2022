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
    
    VS_OUTPUT output = (VS_OUTPUT)0;
    output.Pos = mul( pos4, World);
    output.PosW = output.Pos;
    output.NormalW = normalize(mul(Normal4, World));
    output.Pos = mul( output.Pos, View );
    output.Pos = mul( output.Pos, Projection );
    
    float DiffuseAmount = dot(normalize(DirectionToLight), output.NormalW);
    output.Color = DiffuseAmount * (DiffuseMaterial * DiffuseLight);
    return output;
}


//--------------------------------------------------------------------------------------
// Pixel Shader
//--------------------------------------------------------------------------------------
float4 PS( VS_OUTPUT input ) : SV_Target
{
    return input.Color;
}
