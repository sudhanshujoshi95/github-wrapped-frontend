// ProfileData Model
class ProfileData {
  final String login;
  final String name;
  final String avatarUrl;
  final String bio;
  final String? company;
  final String location;
  final String createdAt;
  final PublicRepos publicRepos;
  final Followers followers;
  final Following following;

  ProfileData({
    this.login = '',
    this.name = 'Unknown',
    this.avatarUrl = '',
    this.bio = '',
    this.company,
    this.location = 'Not specified',
    this.createdAt = '',
    PublicRepos? publicRepos,
    Followers? followers,
    Following? following,
  })  : publicRepos = publicRepos ?? PublicRepos(totalCount: 0),
        followers = followers ?? Followers(totalCount: 0),
        following = following ?? Following(totalCount: 0);

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      login: (json['login'] as String?) ?? '',
      name: (json['name'] as String?) ?? 'Unknown',
      avatarUrl: (json['avatarUrl'] as String?) ?? '',
      bio: (json['bio'] as String?) ?? '',
      company: json['company'] as String?,
      location: (json['location'] as String?) ?? 'Not specified',
      createdAt: (json['createdAt'] as String?) ?? '',
      publicRepos: json['publicRepos'] != null
          ? PublicRepos.fromJson(json['publicRepos'])
          : null,
      followers: json['followers'] != null
          ? Followers.fromJson(json['followers'])
          : null,
      following: json['following'] != null
          ? Following.fromJson(json['following'])
          : null,
    );
  }
}

class PublicRepos {
  final int totalCount;

  PublicRepos({this.totalCount = 0});

  factory PublicRepos.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return PublicRepos(
        totalCount: (json['totalCount'] as int?) ?? 0,
      );
    }
    return PublicRepos();
  }
}

class Followers {
  final int totalCount;

  Followers({this.totalCount = 0});

  factory Followers.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return Followers(
        totalCount: (json['totalCount'] as int?) ?? 0,
      );
    }
    return Followers();
  }
}

class Following {
  final int totalCount;

  Following({this.totalCount = 0});

  factory Following.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return Following(
        totalCount: (json['totalCount'] as int?) ?? 0,
      );
    }
    return Following();
  }
}

class MostActiveDay {
  final String mostActiveDay;
  final int maxContributions;

  MostActiveDay({
    this.mostActiveDay = '',
    this.maxContributions = 0,
  });

  factory MostActiveDay.fromJson(Map<String, dynamic> json) {
    return MostActiveDay(
      mostActiveDay: (json['mostActiveDay'] as String?) ?? '',
      maxContributions: (json['maxContributions'] as int?) ?? 0,
    );
  }
}

class MostUsedLanguage {
  final String language;
  final int count;

  MostUsedLanguage({
    this.language = '',
    this.count = 0,
  });

  factory MostUsedLanguage.fromJson(Map<String, dynamic> json) {
    return MostUsedLanguage(
      language: (json['language'] as String?) ?? '',
      count: (json['count'] as int?) ?? 0,
    );
  }
}

class Repo {
  final String name;
  final int stargazerCount;
  final int forkCount;
  final String createdAt;
  final List<Language> languages;

  Repo({
    this.name = '',
    this.stargazerCount = 0,
    this.forkCount = 0,
    this.createdAt = '',
    this.languages = const [],
  });

  factory Repo.fromJson(Map<String, dynamic> json) {
    var languageList = json['languages'] != null
        ? (json['languages']['nodes'] as List?)
            ?.map((language) => Language.fromJson(language))
            .toList()
        : <Language>[];

    return Repo(
      name: (json['name'] as String?) ?? '',
      stargazerCount: (json['stargazerCount'] as int?) ?? 0,
      forkCount: (json['forkCount'] as int?) ?? 0,
      createdAt: (json['createdAt'] as String?) ?? '',
      languages: languageList ?? [],
    );
  }
}

class Language {
  final String name;

  Language({this.name = ''});

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      name: (json['name'] as String?) ?? '',
    );
  }
}

class MostContributedRepo {
  final String mostContributedRepo;
  final int maxCommits;

  MostContributedRepo({
    this.mostContributedRepo = '',
    this.maxCommits = 0,
  });

  factory MostContributedRepo.fromJson(Map<String, dynamic> json) {
    return MostContributedRepo(
      mostContributedRepo: (json['mostContributedRepo'] as String?) ?? '',
      maxCommits: (json['maxCommits'] as int?) ?? 0,
    );
  }
}

class GitHubData {
  final ProfileData profileData;
  final MostActiveDay mostActiveDay;
  final List<MostUsedLanguage> mostUsedLanguages;
  final List<Repo> reposIn2024;
  final MostContributedRepo mostContributedRepo;
  final int longestStreak;

  GitHubData({
    ProfileData? profileData,
    MostActiveDay? mostActiveDay,
    this.mostUsedLanguages = const [],
    this.reposIn2024 = const [],
    MostContributedRepo? mostContributedRepo,
    this.longestStreak = 0,
  })  : profileData = profileData ?? ProfileData(),
        mostActiveDay = mostActiveDay ?? MostActiveDay(),
        mostContributedRepo = mostContributedRepo ?? MostContributedRepo();

  factory GitHubData.fromJson(Map<String, dynamic> json) {
    var mostUsedLanguagesList = (json['mostUsedLanguages'] as List?)
            ?.map((language) => MostUsedLanguage.fromJson(language))
            .toList() ??
        <MostUsedLanguage>[];

    var reposIn2024List = (json['reposIn2024'] as List?)
            ?.map((repo) => Repo.fromJson(repo))
            .toList() ??
        <Repo>[];

    return GitHubData(
      profileData: json['profileData'] != null
          ? ProfileData.fromJson(json['profileData'])
          : null,
      mostActiveDay: json['mostActiveDay'] != null
          ? MostActiveDay.fromJson(json['mostActiveDay'])
          : null,
      mostUsedLanguages: mostUsedLanguagesList,
      reposIn2024: reposIn2024List,
      mostContributedRepo: json['mostContributedRepo'] != null
          ? MostContributedRepo.fromJson(json['mostContributedRepo'])
          : null,
      longestStreak: (json['longestStreak'] as int?) ?? 0,
    );
  }
}
