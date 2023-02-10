import Types "../types";
import Nat "mo:base/Nat";

module {
    type Course = Types.Course;
    type Duration = Types.Duration;

    public func computeGemsForViews(course: Course, checkpoint: Duration) : Nat{
        // The total awardable gems for a course
        let awardableGems = course.totalGems;
        // Total seconds played by the user
        let secondsPlayed = checkpoint.minute * 60 + checkpoint.second;
        // Total amount of seconds of the course
        let totalSeconds = course.totalDuration.minute * 60 + course.totalDuration.second;
        if(secondsPlayed > totalSeconds) {
            // The user can't have watched a course for longer than its duration:
            // the function has been called with wrong parameters
            return 0;
        };
        // The total awrded gems will be given with respect to the percentage of the
        // seconds of the course which have been watched. The number will be rounded to
        // the closest integer
        let percentageOfCompletion : Nat = (secondsPlayed / totalSeconds);
        return awardableGems * percentageOfCompletion;
    };

};