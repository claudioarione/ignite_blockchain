import Array "mo:base/Array";
import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";
import Types "./types";
import Nat "mo:base/Nat";

module {
  type Course = Types.Course;
  type CourseId = Types.CourseId;
  type Quiz = Types.Quiz;

  actor class CoursesTable() {
    // Again, the "database" is just a local hash map
    let hashMap = HashMap.HashMap<CourseId, Course>(1, equalityPredicate, Principal.hash);

    public func createOne(courseId: CourseId, course: Course) : async() {
      hashMap.put(courseId, course);
    };

    public func findById(courseId: CourseId): async ?Course {
      hashMap.get(courseId);
    };

    public func updateTotalGems(id: CourseId, gems: Nat) : async() {
        let course : ?Course = hashMap.get(id);
        ignore do ? {
          hashMap.put(id, {
            id = id;
            progressiveNumber = course!.progressiveNumber;
            title = course!.title;
            description = course!.description;
            videoUrl = course!.videoUrl;
            totalDuration = course!.totalDuration;
            totalGems = course!.totalGems;
            finalQuizzes = course!.finalQuizzes;
          });
        };
    };

    public func addQuiz(id : CourseId, quiz: Quiz) : async() {
        let course : ?Course = hashMap.get(id);
        ignore do ? {
          var quizzes : [Quiz] = course!.finalQuizzes;
          quizzes := Array.append<Quiz>(quizzes, [quiz]);
          hashMap.put(id, {
              id = id;
              progressiveNumber = course!.progressiveNumber;
              title = course!.title;
              description = course!.description;
              videoUrl = course!.videoUrl;
              totalDuration = course!.totalDuration;
              totalGems = course!.totalGems;
              finalQuizzes = quizzes;
          });
        };
    };

  };

  func equalityPredicate(x: CourseId, y: CourseId): Bool { x == y };
};
