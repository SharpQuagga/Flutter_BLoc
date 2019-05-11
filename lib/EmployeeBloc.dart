//TODO: imports
//TODO: List of Employees
//TODO: Stream Controllers
//TODO: Stream Sink getter
//TODO: Constructor - add data
//TODO: Core Functions
//TODO: dispose

import 'Employee.dart';
import 'dart:async';

class EmployeeBloc{

  //sink to add data in pipe
  //stream to get data from pipe
  // pipe means data flow


  List<Employee> _employeeList = [
    Employee(1,"First",100),
    Employee(2,"Second",200),
    Employee(3,"Third",300),
    Employee(4,"Forth",400),
    Employee(5,"Fifth",500),
  ];

  final _employeeListStreamController = StreamController<List<Employee>>();

  //for inc and dec
  final _employeeSalaryIncrementStreamController = StreamController<Employee>();
  final _employeeSalaryDecrementStreamController = StreamController<Employee>();

  Stream<List<Employee>> get employeeListStream => _employeeListStreamController.stream;

  StreamSink<List<Employee>> get employeeListSink => _employeeListStreamController.sink;

  StreamSink<Employee> get employeeSalaryIncrement => _employeeSalaryIncrementStreamController.sink;
  StreamSink<Employee> get employeeSalaryDecrement => _employeeSalaryDecrementStreamController.sink;

  EmployeeBloc(){
    _employeeListStreamController.add(_employeeList);

    _employeeSalaryIncrementStreamController.stream.listen(_incrementSalary);
    _employeeSalaryDecrementStreamController.stream.listen(_decrementSalary);


  }

   _incrementSalary(Employee employee){
     double sal = employee.salary;
      sal = sal + sal*0.2;

      _employeeList[employee.id-1].salary=sal;
      employeeListSink.add(_employeeList); 
  }

     _decrementSalary(Employee employee){
     double sal = employee.salary;
      sal = sal - sal*0.2;

      _employeeList[employee.id-1].salary=sal;
      employeeListSink.add(_employeeList); 
  }

  void dispose(){
    _employeeListStreamController.close();
    _employeeSalaryDecrementStreamController.close();
    _employeeSalaryIncrementStreamController.close();
  }

}
