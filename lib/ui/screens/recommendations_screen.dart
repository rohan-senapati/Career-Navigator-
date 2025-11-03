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
  ConsumerState<RecommendationScreen> createState() =>
      _RecommendationScreenState();
}

class _RecommendationScreenState extends ConsumerState<RecommendationScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
          _selectedTab == 0 ? 'Discover Careers' : 'Smart Course Recommender',
          style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        backgroundColor: _selectedTab == 0
            ? AppColors.primary
            : const Color(0xFF2C3E50),
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
          if (_selectedTab == 0) // Only show filter for Job Finder
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
        children: [_buildJobsTab(), _buildCoursesTab()],
      ),
      bottomNavigationBar: const CustomNavBar(currentIndex: 2),
    );
  }

  Widget _buildJobsTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(24),
            width: double.infinity,
            color: AppColors.primary,
            child: Column(
              children: [
                Text(
                  'Find Your Dream Job',
                  style: GoogleFonts.inter(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Search through thousands of job listings to find the perfect opportunity for your career growth.',
                  style: GoogleFonts.inter(fontSize: 16, color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          // Search Card
          Transform.translate(
            offset: const Offset(0, -40),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.work_outline,
                        color: AppColors.textSecondary,
                      ),
                      hintText: 'Job Title (e.g. Web Developer)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: AppColors.primary),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.location_on_outlined,
                        color: AppColors.textSecondary,
                      ),
                      hintText: 'Location (e.g. Mumbai)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: AppColors.primary),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.search),
                      label: const Text('Search Jobs'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Search Results
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.search, color: AppColors.textPrimary),
                    const SizedBox(width: 8),
                    Text(
                      'Search Results',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Placeholder for results
                Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      const CircularProgressIndicator(),
                      const SizedBox(height: 20),
                      Text(
                        'Searching for jobs...',
                        style: GoogleFonts.inter(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCoursesTab() {
    final coursesAsync = ref.watch(courseRecommendationsProvider);

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 64),
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF3498DB), Color(0xFF2980B9)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                Text(
                  'Discover Your Perfect Course',
                  style: GoogleFonts.inter(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Get personalized course recommendations based on your interests and goals',
                  style: GoogleFonts.inter(fontSize: 16, color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          Transform.translate(
            offset: const Offset(0, -40),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha:0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Find Your Next Course',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            hint: const Text('Select a course'),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: AppColors.primary),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton.icon(
                        onPressed: () {
                          ref.invalidate(courseRecommendationsProvider);
                        },
                        icon: const Icon(Icons.search, size: 18),
                        label: const Text('Get'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Popular Courses',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                coursesAsync.when(
                  data: (courses) {
                    if (courses.isEmpty) {
                      return _buildEmptyState(
                        'No course recommendations available',
                      );
                    }
                    return Column(
                      children: courses
                          .map((course) => _buildCourseCard(course))
                          .toList(),
                    );
                  },
                  loading: () => _buildLoadingState(),
                  error: (error, stack) => _buildErrorState(error.toString()),
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
            color: Colors.grey.withValues(alpha:0.1),
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
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Center(
              child: Icon(
                Icons.play_circle_outline,
                size: 48,
                color: Colors.white.withValues(alpha:0.1),
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.accent.withValues(alpha:0.1),
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
                    Icon(
                      Icons.people_outline,
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${(course.numberOfStudents / 1000).toStringAsFixed(0)}K students',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(
                      Icons.schedule,
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
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

              ref.invalidate(courseRecommendationsProvider);
            },
            child: const Text('Try Again'),
          ),
        ],
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
              trailing: Radio(
                value: false,
                groupValue: true,
                onChanged: (v) {},
              ),
            ),
            ListTile(
              leading: const Icon(Icons.attach_money),
              title: const Text('Sort by Salary'),
              trailing: Radio(
                value: false,
                groupValue: true,
                onChanged: (v) {},
              ),
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
