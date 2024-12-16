import 'package:flutter/material.dart';
import 'package:github_wrapped/models/user_model.dart';
import 'package:github_wrapped/services/api_service.dart';

class GitHubDataScreen extends StatefulWidget {
  final String username;

  const GitHubDataScreen({super.key, required this.username});

  @override
  // ignore: library_private_types_in_public_api
  _GitHubDataScreenState createState() => _GitHubDataScreenState();
}

class _GitHubDataScreenState extends State<GitHubDataScreen> {
  late Future<GitHubData> _githubData;

  @override
  void initState() {
    super.initState();
    _githubData = ApiService().fetchGitHubWrapped(widget.username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<GitHubData>(
        future: _githubData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}',
                  style: const TextStyle(color: Colors.red)),
            );
          } else if (snapshot.hasData) {
            final data = snapshot.data!;
            return PageView(
              children: [
                _buildProfileSlide(data),
                _buildMostActiveDaySlide(data),
                _buildStreakSlide(data),
                _buildMostContributedRepoSlide(data),
                _buildLanguagesSlide(data),
                _buildRepositoriesSlide(data),
              ],
            );
          } else {
            return const Center(child: Text('No data available.'));
          }
        },
      ),
    );
  }

  Widget _buildProfileSlide(GitHubData data) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.purple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Image
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(data.profileData.avatarUrl),
              ),
              const SizedBox(height: 20),

              // Name
              Text(
                data.profileData.name,
                style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 10),

              // Bio
              Text(
                data.profileData.bio,
                style: const TextStyle(fontSize: 16, color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Additional Information (Followers, Repos, etc.)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildInfoCard(Icons.people,
                      data.profileData.followers.totalCount, 'Followers'),
                  const SizedBox(width: 20),
                  _buildInfoCard(Icons.folder,
                      data.profileData.publicRepos.totalCount, 'Repos'),
                ],
              ),
              const SizedBox(height: 20),

              // Location, Company, and Other Info
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLocationInfoCard(
                      Icons.location_on, data.profileData.location, 'Location'),
                  const SizedBox(width: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, int value, String label) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 30),
          const SizedBox(height: 8),
          Text(
            value.toString(),
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationInfoCard(IconData icon, String value, String label) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 30),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildMostActiveDaySlide(GitHubData data) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.calendar_today, size: 80, color: Colors.yellow),
            const SizedBox(height: 20),
            const Text(
              "Most Active Day",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              data.mostActiveDay.mostActiveDay,
              style: const TextStyle(fontSize: 18, color: Colors.white70),
            ),
            Text(
              "Contributions: ${data.mostActiveDay.maxContributions}",
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMostContributedRepoSlide(GitHubData data) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.commit_outlined, size: 80, color: Colors.yellow),
            const SizedBox(height: 20),
            const Text(
              "Most Contributions",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              data.mostContributedRepo.mostContributedRepo,
              style: const TextStyle(fontSize: 18, color: Colors.white70),
            ),
            Text(
              "Commits: ${data.mostContributedRepo.maxCommits}",
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguagesSlide(GitHubData data) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.deepOrange,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Most Used Languages",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 20),
            ...data.mostUsedLanguages.map((language) {
              return ListTile(
                title: Text(language.language,
                    style: const TextStyle(color: Colors.white)),
                subtitle: Text("Usage Count: ${language.count}",
                    style: const TextStyle(color: Colors.white70)),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildRepositoriesSlide(GitHubData data) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.teal,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Repositories you worked on this year!",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 20),
            ...data.reposIn2024.map((repo) {
              return ListTile(
                title: Text(repo.name,
                    style: const TextStyle(color: Colors.white)),
                subtitle: Text(
                  "Stars: ${repo.stargazerCount} | Forks: ${repo.forkCount}",
                  style: const TextStyle(color: Colors.white70),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildStreakSlide(GitHubData data) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [Colors.red, Colors.orange]),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.local_fire_department,
                size: 80, color: Colors.white),
            const SizedBox(height: 20),
            const Text(
              "Longest Streak",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              "${data.longestStreak} days",
              style: const TextStyle(fontSize: 18, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}
