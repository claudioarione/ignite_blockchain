import Principal "mo:base/Principal";

module {
  public type UserId = Principal;
  public type CourseId = Principal;
  public type QuizId = Principal;

  type Duration = {
    minute : Nat;
    second : Nat;
  };

  public type NewProfile = {
    firstName : Text;
    lastName : Text;
    age: Nat;
    education : Text;
    imgUrl : Text;
  };

  public type Profile = {
    id : UserId;
    firstName : Text;
    lastName : Text;
    age: Nat;
    education : Text;
    imgUrl : Text;
  };

  public type Course = {
    id : CourseId;
    progressiveNumber: Nat;
    title: Text;
    description: Text;
    videoUrl : Text;
    totalDuration: Duration;
    totalGems: Nat;
    finalQuizzes: [Quiz];
  };

  public type Progress = {
    userId: UserId;
    courseId: CourseId;
    checkpoint: Duration;
    gemsEarned: Nat;
    quizzesCompleted: [Quiz];
  }

  public type Quiz = {
    id: QuizId;
    question: Text;
    answers: [Text];
    correctAnswer: Text;
    gems: Nat;
  }

};
