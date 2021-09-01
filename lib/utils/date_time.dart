String timeAgo(final int releaseTime) {
  final date = DateTime.fromMillisecondsSinceEpoch(releaseTime * 1000, isUtc: true);
  final Duration duration = DateTime.now().difference(date);
  final now = DateTime.now().toUtc();
  final yearsAgo = (duration.inDays/365).floor();
  final monthsAgo; // = (duration.inDays/31).floor();
  final daysAgo;
  final hoursAgo; // = duration.inHours;
  final minutesAgo;// = now.minute - date.minute;
  final secondsAgo;// = now.second - date.second;
  final String releaseTimeAgo;
  if (yearsAgo > 0)
    releaseTimeAgo =
        yearsAgo.toString() + (yearsAgo > 1 ? " years ago" : " year ago");
  else if ((monthsAgo = (duration.inDays/31).floor()) > 0)
    releaseTimeAgo =
        monthsAgo.toString() + (monthsAgo > 1 ? " months ago" : " month ago");
  else if ((daysAgo = duration.inDays) > 0)
    releaseTimeAgo = daysAgo.toString() + (daysAgo > 1 ? " days ago" : " day ago");
  else if ((hoursAgo = duration.inHours) > 0)
    releaseTimeAgo =
        hoursAgo.toString() + (hoursAgo > 1 ? " hours ago" : " hour ago");
  else if ((minutesAgo = duration.inMinutes) > 0)
    releaseTimeAgo = minutesAgo.toString() +
        (minutesAgo > 1 ? " minutes ago" : " minute ago");
  else{
    secondsAgo = duration.inSeconds;
    releaseTimeAgo = secondsAgo.toString() +
        (secondsAgo > 1 ? " seconds ago" : " second ago");
  }
  return releaseTimeAgo;
}