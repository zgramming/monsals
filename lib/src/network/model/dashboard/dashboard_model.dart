import 'package:equatable/equatable.dart';

class DashboardModel extends Equatable {
  const DashboardModel({
     this.totalRencana = 0,
     this.totalRealisasi = 0,
     this.totalPenjualan = 0,
     this.persentasi = 0,
  });

  final int totalRencana;
  final int totalRealisasi;
  final int totalPenjualan;
  final int persentasi;

  @override
  List<Object> get props => [totalRencana, totalRealisasi, totalPenjualan, persentasi];

  @override
  bool get stringify => true;

  DashboardModel copyWith({
    int? totalRencana,
    int? totalRealisasi,
    int? totalPenjualan,
    int? persentasi,
  }) {
    return DashboardModel(
      totalRencana: totalRencana ?? this.totalRencana,
      totalRealisasi: totalRealisasi ?? this.totalRealisasi,
      totalPenjualan: totalPenjualan ?? this.totalPenjualan,
      persentasi: persentasi ?? this.persentasi,
    );
  }
}
