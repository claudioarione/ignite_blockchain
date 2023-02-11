import Courses "data_tables/course_table_stub";
import Progresses "data_tables/progress_table_stub";
import Users "data_tables/user_table_stub";
import Types "./types";
import Result "mo:base/Result";
import Error "mo:base/Error";
import Bool "mo:base/Bool";

actor class Main() {

    let courseTable = Courses.CoursesTable();
    let progressTable = Progresses.ProgressTable();
    let userTable = Users.UserTable();

    // Creates a new profile for a user that wants to login
    public shared(msg) func registerNewUser(profile : Types.NewProfile) : async Result.Result<(), Error> {
      let callerId = msg.caller;
      // Reject users with AnonymousIdentity
      if(Principal.toText(callerId) == "2vxsx-fae") {
          return #err("Unauthorized");
      };
      // Then it's possible to associate a user with their identity
      return await userTable.createOne(callerId, profile);
    };

    // Edits the profile of the current user
    public shared(msg) func editUserProfile(newProfile : Types.Profile) : async Result.Result<(), Error> {
      let callerId = msg.caller;
      if(callerId != newProfile.id) {
        // The user is pretending to be someone else
        return #err("Invalid identity");
      };
      return await userTable.updateOne(callerId, newProfile);
    };

    // Retrieves the profile of the current user
    public shared(msg) func getProfileData() : async Result.Result<Profile, Error> {
      let profileId = msg.caller;
      // Search whether exists a profile having the id of the caller
      let result : ?Profile = await userTable.findOne(profileId);
      switch(result) {
        case null { 
          return #err("Your id is not associated to an existing profile");
        };
        case(? result) { 
          return result;
        };
      };
    };

    // This function is called when a user first clicks on a video-course
    public shared(msg) func insertFirstProgress(course : Types.Course, time : Types.Duration) : async () {
      let userId = msg.caller;
      return await progressTable.insertFirstProgress(course, userId, time);
    };

    // This function is called periodically when a user is watching a video-course or 
    // when they exit from it
    public shared(msg) func setLastProgress(course : Types.Course, time : Types.Duration) : async () {
      let userId = msg.caller;
      return await progressTable.setNewCheckpoint(userId, course, time);
    };

    // This function is invoked when a user submits their response to a quiz
    public shared(msg) func answerToQuiz(courseId : Types.CourseId, quiz : Types.Quiz, answer : Text) : async Text {
      let userId = msg.caller;
      let isCorrect : Bool = (answer == quiz.correctAnswer);
      // Call function of class ProgressTable
      await progressTable.onQuizCompleted(courseId, userId, quiz, isCorrect);
      if(isCorrect) {
          return "Correct answer, congratulations";
      };
      return "Wrong answer";
    };

    // Note: all the methods about insertion, update and retrieval of courses are not
    // managed in this sample actor, which aims to show the interaction with the user
};
