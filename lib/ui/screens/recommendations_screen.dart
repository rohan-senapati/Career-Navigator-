import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/themes.dart';
import '../../models/recommendation.dart';
import '../../services/recommendation_service.dart';
import '../widgets/navbar.dart';

class RecommendationScreen extends ConsumerStatefulWidget {
  const RecommendationScreen({super.key});

  @override
  ConsumerState<RecommendationScreen> createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends ConsumerState<RecommendationScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTab = 0;



  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedTab = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'Discover Careers',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: Navigator.of(context).canPop()
            ? IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => context.pop(),
        )
            : IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => context.go('/'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          labelStyle: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          tabs: const [
            Tab(text: 'Job Finder'),
            Tab(text: 'Courses'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildJobsTab(),
          _buildCoursesTab(),
        ],
      ),
      bottomNavigationBar: const CustomNavBar(currentIndex: 2),
    );
  }

  Widget _buildJobsTab() {
    final careersAsync = ref.watch(careerRecommendationsProvider);

    return careersAsync.when(
      data: (careers) {
        if (careers.isEmpty) {
          return _buildEmptyState('No career recommendations available');
        }

        return RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(careerRecommendationsProvider);
          },
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildSectionHeader(
                'Top Career Matches',
                'Based on your profile and interests',
              ),
              const SizedBox(height: 16),
              ...careers.map((career) => _buildCareerCard(career)),
            ],
          ),
        );
      },
      loading: () => _buildLoadingState(),
      error: (error, stack) => _buildErrorState(error.toString()),
    );
  }

  Widget _buildCoursesTab() {
    final coursesAsync = ref.watch(courseRecommendationsProvider);

    return coursesAsync.when(
      data: (courses) {
        if (courses.isEmpty) {
          return _buildEmptyState('No course recommendations available');
        }

        return RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(courseRecommendationsProvider);
          },
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildSectionHeader(
                'Top Courses',
                'Learn new skills and advance your career',
              ),
              const SizedBox(height: 16),
              ...courses.map((course) => _buildCourseCard(course)),
            ],
          ),
        );
      },
      loading: () => _buildLoadingState(),
      error: (error, stack) => _buildErrorState(error.toString()),
    );
  }

  Widget _buildSectionHeader(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildCareerCard(CareerRecommendation career) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.work_outline,
                    color: AppColors.primary,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              career.title,
                              style: GoogleFonts.inter(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                          _buildConfidenceBadge(career.confidence),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        career.category,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              career.description,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildInfoChip(
                  Icons.attach_money,
                  '\$${(career.salaryRange / 1000).toStringAsFixed(0)}K',
                  AppColors.success,
                ),
                const SizedBox(width: 8),
                _buildInfoChip(
                  Icons.trending_up,
                  '+${career.growthRate}%',
                  AppColors.info,
                ),
                const SizedBox(width: 8),
                _buildInfoChip(
                  Icons.schedule,
                  '${career.estimatedTimeToTransition}mo',
                  AppColors.warning,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: career.requiredSkills
                  .take(3)
                  .map((skill) => _buildSkillChip(skill))
                  .toList(),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey.shade200),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextButton.icon(
                    onPressed: () => _showCareerDetails(career),
                    icon: const Icon(Icons.info_outline, size: 18),
                    label: const Text('Learn More'),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: Colors.grey.shade200,
                ),
                Expanded(
                  child: TextButton.icon(
                    onPressed: () => _saveCareer(career),
                    icon: const Icon(Icons.bookmark_outline, size: 18),
                    label: const Text('Save'),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.secondary,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseCard(CourseRecommendation course) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.accent, AppColors.accentDark],
              ),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Center(
              child: Icon(
                Icons.play_circle_outline,
                size: 48,
                color: Colors.white.withValues(alpha: 0.9),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.accent.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        course.provider,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.accent,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.star, size: 16, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(
                      course.rating.toStringAsFixed(1),
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  course.title,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  course.description,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.people_outline, size: 16, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    Text(
                      '${(course.numberOfStudents / 1000).toStringAsFixed(0)}K students',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(Icons.schedule, size: 16, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    Text(
                      '${course.duration}h',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '\$${course.price.toStringAsFixed(2)}',
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _showCourseDetails(course),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('View Course'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfidenceBadge(double confidence) {
    Color color;
    String label;

    if (confidence >= 0.8) {
      color = AppColors.success;
      label = 'High Match';
    } else if (confidence >= 0.6) {
      color = AppColors.warning;
      label = 'Good Match';
    } else {
      color = AppColors.grey;
      label = 'Fair Match';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.verified, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillChip(String skill) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
      ),
      child: Text(
        skill,
        style: GoogleFonts.inter(
          fontSize: 12,
          color: AppColors.primary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: AppColors.primary),
          const SizedBox(height: 16),
          Text(
            'Loading recommendations...',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            message,
            style: GoogleFonts.inter(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              ref.invalidate(careerRecommendationsProvider);
              ref.invalidate(skillRecommendationsProvider);
              ref.invalidate(courseRecommendationsProvider);
            },
            child: const Text('Refresh'),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: AppColors.error),
          const SizedBox(height: 16),
          Text(
            'Something went wrong',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            error,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              ref.invalidate(careerRecommendationsProvider);
              ref.invalidate(skillRecommendationsProvider);
              ref.invalidate(courseRecommendationsProvider);
            },
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  void _showCareerDetails(CareerRecommendation career) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: ListView(
            controller: scrollController,
            padding: const EdgeInsets.all(24),
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                career.title,
                style: GoogleFonts.inter(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                career.category,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 24),
              _buildDetailSection('Description', career.description),
              const SizedBox(height: 16),
              _buildDetailSection(
                'Required Skills',
                career.requiredSkills.join(', '),
              ),
              const SizedBox(height: 16),
              _buildDetailSection(
                'Recommended Skills',
                career.recommendedSkills.join(', '),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildStatBox(
                      'Salary',
                      '\$${(career.salaryRange / 1000).toStringAsFixed(0)}K',
                      Icons.attach_money,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatBox(
                      'Growth',
                      '+${career.growthRate}%',
                      Icons.trending_up,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _saveCareer(career);
                  },
                  child: const Text('Save Career Goal'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCourseDetails(CourseRecommendation course) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(course.title),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(course.description),
              const SizedBox(height: 16),
              Text('Provider: ${course.provider}'),
              Text('Instructor: ${course.instructors.join(", ")}'),
              Text('Duration: ${course.duration} hours'),
              Text('Level: ${course.level}'),
              Text('Price: \$${course.price}'),
              Text('Rating: ${course.rating} ⭐'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Opening course...')),
              );
            },
            child: const Text('Enroll'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: AppColors.textSecondary,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildStatBox(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.primary, size: 32),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  void _saveCareer(CareerRecommendation career) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${career.title} saved to your career goals'),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Recommendations'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.sort),
              title: const Text('Sort by Relevance'),
              trailing: Radio(value: true, groupValue: true, onChanged: (v) {}),
            ),
            ListTile(
              leading: const Icon(Icons.trending_up),
              title: const Text('Sort by Growth Rate'),
              trailing: Radio(value: false, groupValue: true, onChanged: (v) {}),
            ),
            ListTile(
              leading: const Icon(Icons.attach_money),
              title: const Text('Sort by Salary'),
              trailing: Radio(value: false, groupValue: true, onChanged: (v) {}),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }
}