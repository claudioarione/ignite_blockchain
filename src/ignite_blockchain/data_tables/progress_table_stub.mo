import Array "mo:base/Array";
import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";
import Types "./types";
import Nat "mo:base/Nat";
import Bool "mo:base/Bool";
import GemCalculator "../utils/gems";

module {
    type Progress = Types.Progress;
    type UserId = Types.UserId;
    type CourseId = Types.CourseId;
    type Course = Types.Course;
    type Duration = Types.Duration;
    type Quiz = Types.Quiz;

    public type ProgressId = {
        userId: UserId;
        courseId: CourseId;
    };

    actor class ProgressTable() {
        // Again, the "database" is just a local hash map
        let hashMap = HashMap.HashMap<ProgressId, Progress>(1, equalityPredicate, Principal.hash);

        public func insertFirstProgress(course: Course, uId: UserId, ckpt: Duration) {
            let progressId = {
                userId = uId;
                courseId = course.id;
            };
            let gems = GemCalculator.computeGemsForViews(course, ckpt);
            hashMap.put(progressId, {
                userId = uId;
                courseId = course.id;
                checkpoint = ckpt;
                gemsEarned = gems;
                quizzesCompleted = [];
            });
        };

        public func findById(cId: CourseId, uId: UserId): async ?Progress {
            let progressId = {
                userId = uId;
                courseId = cId;
            };
            hashMap.get(progressId);
        };

        public func onQuizCompleted(cId: CourseId, uId: UserId, quiz: Quiz, isCorrect: Bool) {
            let progressId = {
                userId = uId;
                courseId = cId;
            };
            let progress : ?Progress = hashMap.get(progressId);
            if(progress != null) {
               return;
            };
            ignore do ? {
              var gems : Nat = (progress!).gemsEarned;
              if(isCorrect) {
                  gems += quiz.gems;
              };
              var quizzes : [Quiz] = progress!.quizzesCompleted;
              quizzes := Array.append<Quiz>(quizzes, [quiz]);
              hashMap.put(progressId, {
                  userId = uId;
                  courseId = cId;
                  checkpoint = progress!.checkpoint;
                  gemsEarned = gems;
                  quizzesCompleted = quizzes;
              });
            }
        };

        public func setNewCheckpoint(uId: UserId, course: Course, newCkpt: Duration) {
            let progressId = {
                userId = uId;
                courseId = course.id;
            };
            let oldProgress : ?Progress = hashMap.get(progressId);
            ignore do ? {
              if(newCkpt.minute < oldProgress!.checkpoint.minute or 
                (newCkpt.minute == oldProgress!.checkpoint.minute and 
                newCkpt.second < oldProgress!.checkpoint.second)
              ) {
                  // The provided value of the checkpoint is not valid
                  // because it represents a time before the current one
                  return;
              };
              let newGemsValue = GemCalculator.computeGemsForViews(course, newCkpt);
              hashMap.put(progressId, {
                  userId = uId;
                  courseId = course.id;
                  checkpoint = newCkpt;
                  gemsEarned = newGemsValue;
                  quizzesCompleted = oldProgress!.quizzesCompleted;
              });
            };
        };

    };

    func equalityPredicate(x: ProgressId, y: ProgressId): Bool { 
        x.userId == y.userId and x.courseId == y.courseId
    };
};