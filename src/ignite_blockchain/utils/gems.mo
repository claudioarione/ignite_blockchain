import Types "../types";
import Nat "mo:base/Nat";
import CourseTableStub "../data_tables/course_table_stub";
import Types "../types";
import Types "./types";
import CourseTable "../data_tables/course_table_stub.mo"

module {
    type Progress = Types.Progress;
    type Course = Types.Course;
    type Duration = Types.Duration;

    public func computeGemsForViews(course: Course, checkpoint: Duration) : Nat{
        // The total awardable gems for a course
        let awardableGems = course.totalGems;
        // Total seconds played by the user
        let secondsPlayed = checkpoint.minute * 60 + checkpoint.second;
        // Total amount of seconds of the course
        let totalSeconds = course.totalDuration.minute * 60 + course.totalDuration.second;
        // The total awrded gems will be given with respect to the percentage of the
        // seconds of the course which have been watched. The number will be rounded to
        // the closest integer
        let percentageOfCompletion : Nat = (secondsPlayed / totalSeconds);
        return awardableGems * percentageOfCompletion;
    }

};