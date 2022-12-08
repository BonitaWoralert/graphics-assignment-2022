#pragma once
#include <windows.h>
#include <d3d11_1.h>
#include <d3dcompiler.h>
#include <directxmath.h>
#include <directxcolors.h>
#include "resource.h"

using namespace DirectX;

/*
struct SimpleVertex
{
    XMFLOAT3 Pos;
    XMFLOAT3 Normal;
    XMFLOAT2 TexCoord;
};
*/


struct ConstantBuffer
{
	XMMATRIX mWorld;
	XMMATRIX mView;
	XMMATRIX mProjection;

	XMFLOAT4 DiffLight;
	XMFLOAT4 DiffMat;
	XMFLOAT3 DirToLight;
	FLOAT pad;
	XMFLOAT4 AmbLight;
	XMFLOAT4 AmbMat;

	XMFLOAT4 SpecMat;
	XMFLOAT4 SpecLight;
	FLOAT SpecPower;
	XMFLOAT3 EyeWorldPos;
};