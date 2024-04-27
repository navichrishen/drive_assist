import 'package:flutter/material.dart';

class MyVehicleContainer extends StatelessWidget {
  final String? imageUrl; // Make imageUrl optional
  final String brand;
  final String model;
  final String manufactureYear;
  final VoidCallback onDeletePressed;
  final VoidCallback onUpdatePressed;
  final VoidCallback onScanPressed;

  const MyVehicleContainer({
    Key? key,
    this.imageUrl, // Make imageUrl optional
    required this.brand,
    required this.model,
    required this.manufactureYear,
    required this.onDeletePressed,
    required this.onUpdatePressed,
    required this.onScanPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      // margin: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey[200],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image and Text Row
          Row(
            children: [
              // Vehicle Image (Circle)
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: imageUrl != null && imageUrl!.isNotEmpty
                      ? Image.network(
                          imageUrl!,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/images/vehicleIcon.png', // Provide default image path here
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              SizedBox(width: 10),
              // Brand and Manufacture Year
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Brand: $brand',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      softWrap: true,
                    ),
                    Text(
                      'Model: $model',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      softWrap: true,
                    ),
                    Text(
                      'Manufacture Year: $manufactureYear',
                      style: TextStyle(fontSize: 16),
                      softWrap: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildIconButton(Icons.delete, onDeletePressed),
              _buildIconButton(Icons.edit, onUpdatePressed),
              _buildIconButton(Icons.car_crash, onScanPressed),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: Colors.black, width: 1.0),
      ),
      child: IconButton(
        icon: Icon(icon),
        onPressed: onPressed,
        tooltip: '',
      ),
    );
  }
}
