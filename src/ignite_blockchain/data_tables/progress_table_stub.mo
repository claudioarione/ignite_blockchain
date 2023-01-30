import Array "mo:base/Array";
import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";
import Types "./types";
import Nat "mo:base/Nat";
import Bool "mo:base/Bool";

module {
    type Progress = Types.Progress;
    type UserId = Types.UserId;
    type CourseId = Types.CourseId;

    public type ProgressId = {
        userId: UserId;
        courseId: CourseId;
    };

    public class ProgressTable() {
        // Again, the "database" is just a local hash map
        let hashMap = HashMap.HashMap<ProgressId, Progress>(1, equalityPredicate, Principal.hash);

        public func insertFirstProgress(cId: CourseId, uId: UserId, ckpt: Duration) {
            let progressId = {
                userId = uId;
                courseId = cId;
            };
            let gems = computeGemsForViews(cId);
            hashMap.put(progressId, {
                userId = uId;
                courseId = cId;
                checkpoint = ckpt;
                gemsEarned = gems;
                quizzesCompleted = [];
            });
        };

        public func findById(cId: CourseId, uId: UserId): ?Progress {
            let progressId = {
                userId = uId;
                courseId = cId;
            };
            hashMap.get(progressId);
        };

        func computeGemsForViews(cId : CourseId) : Nat {
            
        };

        func computeGemsForQuiz(cId : CourseId, quiz: Quiz) : Nat {
            
        };

        public func onQuizCompleted(cId: CourseId, uId: UserId, quiz: Quiz, isCorrect: Bool) {
            let progressId = {
                userId = uId;
                courseId = cId;
            };
            let progress : ?Progress = hashMap.get(progressId);
            if(progress == null) return;
            let gems = progress.gemsEarned;
            if(isCorrect) {
                gems += computeGemsForQuiz(cId, quiz)
            }
            var quizzes : [Quiz] = course.quizzesCompleted;
            quizzes := Array.append<Quiz>(quizzes, [quiz]);
            hashMap.put(progressId, {
                userId = uId;
                courseId = cId;
                checkpoint = progress.checkpoint;
                gemsEarned = gems;
                quizzesCompleted = quizzes;
            });
        };

    };

    func equalityPredicate(x: ProgressId, y: ProgressId): Bool { 
        x.userId == y.userId and x.courseId == y.courseId
    };
};
