import 'movie.dart';

enum Status {
  ACCEPTED,
  UNKNOWN,
  DECLINED
}

class Candidate {
  Candidate(this.movie, this.time, this.cinema);

  final Movie movie;
  final DateTime time;
  final String cinema;
  Status status = Status.UNKNOWN;


  @override
  int get hashCode => movie.hashCode ^ time.hashCode ^ cinema.hashCode;
}