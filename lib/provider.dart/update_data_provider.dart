import 'package:flutter/widgets.dart';
import 'package:ropstam_test/models/car_model.dart';

class UpdateDataProvider extends ChangeNotifier {
  bool _isHidePassword = false;
  bool get hidePassword => _isHidePassword;
  setHidePassword() {
    _isHidePassword = !_isHidePassword;
    notifyListeners();
  }

  bool _isShowPassword = false;
  bool get showPassword => _isShowPassword;
  setShowPassword() {
    _isShowPassword = !_isShowPassword;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  setLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }

  List<CarModel> carModelList = [
    CarModel(
        image: "assets/images/car1.png",
        ownerName: "Kamran",
        vehicleColor: "Blue",
        vehicleName: "Honda Civic"),
    CarModel(
        image: "assets/images/car2.png",
        ownerName: "Kashif",
        vehicleColor: "Red",
        vehicleName: "Toyota"),
    CarModel(
        image: "assets/images/car3.png",
        ownerName: "Bilal",
        vehicleColor: "Black",
        vehicleName: "Suzuki"),
    CarModel(
        image: "assets/images/car4.png",
        ownerName: "Ahmad",
        vehicleColor: "Whit",
        vehicleName: "BMW"),
  ];
}
