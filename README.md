Augmented Reality Project
Overview
This project implements an augmented reality application that superimposes a 3D cube onto a video scene. The project was developed as part of the UE S1-22 course by HAMDI Massyl Yanis
Features

Camera calibration
Homography estimation
Pose estimation
Feature tracking
3D object projection (cube)

Technologies Used

MATLAB
Computer Vision Toolbox
Image Processing Toolbox

Project Structure

Camera Calibration: Determines the intrinsic and extrinsic parameters of the camera.
Homography Estimation: Calculates the transformation between the scene plane and the image plane.
Pose Estimation: Determines the position and orientation of the camera relative to the scene.
Feature Tracking: Tracks points of interest across video frames using MATLAB's Vision.PointTracker.
3D Object Projection: Projects a 3D cube onto the video scene using the calculated projection matrix.

Installation

Ensure you have MATLAB installed with the Computer Vision Toolbox and Image Processing Toolbox.
Clone this repository to your local machine.

Usage

Run the main script in MATLAB.
The script will process the input video and generate an output video with the augmented 3D cube.

Videos

Input Video: https://github.com/user-attachments/assets/41dcedef-0156-424d-8f00-bdc241a1cc31
Output Video: https://github.com/user-attachments/assets/550ff465-2cf3-4783-8b99-bddd863bf3a1

Results
The project successfully implements an augmented reality application with minimal error in rotation and translation matrices. The 3D cube is accurately projected onto the video scene.
