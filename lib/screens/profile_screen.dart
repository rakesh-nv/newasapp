import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isNotificationsEnabled = true;
  bool isSocialMediaEnabled = true;
  bool isLightMod = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Profile Header with Image and Info
              Container(
                padding: EdgeInsets.only(bottom: 24),
                child: Row(
                  children: [
                    // Profile Image
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://i.pravatar.cc/300',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    // Name and Status
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'TheAlphamerc',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Loyal Reader',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Stats Row
              Container(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStat('826', 'Followers'),
                    _buildStat('251', 'Following'),
                    _buildStat('81K', 'News Read'),
                  ],
                ),
              ),

              SizedBox(height: 24),

              _buildSettingTile(
                'Dark',
                Icons.dark_mode,
                isLightMod,
                (value) => setState(() => isLightMod=value),
              ),
              // Settings List
              _buildSettingTile(
                'Notification',
                Icons.notifications_none_outlined,
                isNotificationsEnabled,
                (value) => setState(() => isNotificationsEnabled = value),
              ),
              _buildSettingTile(
                'Social Media',
                Icons.share_outlined,
                isSocialMediaEnabled,
                (value) => setState(() => isSocialMediaEnabled = value),
              ),

              SizedBox(height: 24),

              // Logout Button
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  Icons.logout,
                  color: Colors.red,
                  size: 28,
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  // TODO: Implement logout
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingTile(
    String title,
    IconData icon,
    bool value,
    Function(bool) onChanged,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(
          icon,
          size: 28,
          color: Colors.black87,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Switch.adaptive(
          value: value,
          onChanged: onChanged,
          activeColor: Color(0xFF9D8DDE),
        ),
      ),
    );
  }
}
