import Array "mo:base/Array";
import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";
import Types "./types";

module {
  type NewProfile = Types.NewProfile;
  type Profile = Types.Profile;
  type UserId = Types.UserId;

  actor class UsersTable() {
    // The "database" is just a local hash map
    let hashMap = HashMap.HashMap<UserId, Profile>(1, equalityPredicate, Principal.hash);

    public func createOne(userId: UserId, profile: NewProfile) : async() {
      hashMap.put(userId, makeProfile(userId, profile));
    };

    public func updateOne(userId: UserId, profile: Profile) {
      hashMap.put(userId, profile);
    };

    public func findOne(userId: UserId): ?Profile {
      hashMap.get(userId);
    };


    // Helpers

    func makeProfile(userId: UserId, profile: NewProfile): Profile {
      {
        id = userId;
        firstName = profile.firstName;
        lastName = profile.lastName;
        title = profile.title;
        company = profile.company;
        experience = profile.experience;
        education = profile.education;
        imgUrl = profile.imgUrl;
      }
    };

  };

  func equalityPredicate(x: UserId, y: UserId): Bool { x == y };
};
