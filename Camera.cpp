#include "Camera.h"


Camera::Camera(XMFLOAT3 position, XMFLOAT3 at, XMFLOAT3 up, FLOAT windowWidth, FLOAT windowHeight, FLOAT nearDepth, FLOAT farDepth)
{
	_eye = position;
	_at = at;
	_up = up;
	_windowWidth = windowWidth;
	_windowHeight = windowHeight;
	_nearDepth = nearDepth;
	_farDepth = farDepth;
	_view = XMFLOAT4X4();
	_projection = XMFLOAT4X4();
}

Camera::~Camera()
{
}


void Camera::Update()
{
	//view matrix
	XMVECTOR Eye = XMVectorSet(_eye.x, _eye.y, _eye.z, 0.0f);
	XMVECTOR At = XMVectorSet(_at.x, _at.y, _at.z, 0.0f);
	XMVECTOR Up = XMVectorSet(_up.x, _up.y, _up.z, 0.0f);
	XMStoreFloat4x4(&_view, XMMatrixLookAtLH(Eye, At, Up));

	//projection matrix
	XMStoreFloat4x4(&_projection, XMMatrixPerspectiveFovLH(XM_PIDIV2, _windowWidth / (FLOAT)_windowHeight, _nearDepth, _farDepth));
}

XMFLOAT3 Camera::GetPos() {return _eye;}

XMFLOAT3 Camera::GetLookAt() { return _at; }

XMFLOAT3 Camera::GetUp() { return _up; }

void Camera::SetPos(XMFLOAT3 newPos) { _eye = newPos; }

void Camera::SetLookAt(XMFLOAT3 newLookAt) { _at = newLookAt; }

void Camera::SetUp(XMFLOAT3 newUp) { _up = newUp; }

XMMATRIX Camera::GetViewMatrix()
{ return XMMATRIX(XMLoadFloat4x4(&_view));}

XMMATRIX Camera::GetProjMatrix()
{ return XMMATRIX(XMLoadFloat4x4(&_projection)); }

