#pragma once
#include <windows.h>
#include <d3d11_1.h>
#include <d3dcompiler.h>
#include <directxmath.h>
#include <directxcolors.h>
#include "resource.h"
using namespace DirectX;

class Camera
{
private:
	//private attributes to store the camera position and view 

	XMFLOAT3 _eye;
	XMFLOAT3 _at;
	XMFLOAT3 _up;

	FLOAT _windowWidth;
	FLOAT _windowHeight;
	FLOAT _nearDepth;
	FLOAT _farDepth;

	//attributes to hold view and projection matrices to pass to the shader
	XMFLOAT4X4 _view;
	XMFLOAT4X4 _projection;

public:
	//constructor and destructor for camera
	Camera(XMFLOAT3 position, XMFLOAT3 at, XMFLOAT3 up, FLOAT
		windowWidth, FLOAT windowHeight, FLOAT nearDepth, FLOAT farDepth);
	~Camera();

	//update function for current view/projection matrices
	void Update();

	//set and return position, lookat, up
	//get
	XMFLOAT3 GetPos();
	XMFLOAT3 GetLookAt();
	XMFLOAT3 GetUp();
	//set
	void SetPos(XMFLOAT3 newPos);
	void SetLookAt(XMFLOAT3 newLookAt);
	void SetUp(XMFLOAT3 newUp);

	//get view and projection matrices
	XMMATRIX GetViewMatrix();
	XMMATRIX GetProjMatrix();
};

