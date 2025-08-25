import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

import '../widgets/navbar.dart';

// Message model
class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}

// Chat state provider
final chatMessagesProvider = StateNotifierProvider<ChatNotifier, List<ChatMessage>>(
      (ref) => ChatNotifier(),
);

class ChatNotifier extends StateNotifier<List<ChatMessage>> {
  ChatNotifier() : super([
    ChatMessage(
      text: "Hi! I'm your Career Navigator AI assistant. I'm here to help you with career planning, job search, resume tips, and interview preparation. What would you like to know?",
      isUser: false,
      timestamp: DateTime.now(),
    ),
  ]);

  void addMessage(String text, bool isUser) {
    state = [
      ...state,
      ChatMessage(
        text: text,
        isUser: isUser,
        timestamp: DateTime.now(),
      ),
    ];
  }

  void sendMessage(String userMessage) {
    // Add user message
    addMessage(userMessage, true);

    // Simulate bot response after a delay
    Future.delayed(const Duration(milliseconds: 800), () {
      String botResponse = _generateBotResponse(userMessage);
      addMessage(botResponse, false);
    });
  }

  String _generateBotResponse(String userMessage) {
    final message = userMessage.toLowerCase();

    if (message.contains('career') || message.contains('job')) {
      return "I'd love to help with your career journey! Here are some areas I can assist with:\n\n• Career planning & goal setting\n• Job search strategies\n• Industry insights\n• Skill development paths\n\nWhat specific area interests you most?";
    } else if (message.contains('resume') || message.contains('cv')) {
      return "Resume optimization is crucial for landing interviews! I can help you with:\n\n• Resume structure & formatting\n• Writing compelling bullet points\n• Keyword optimization for ATS\n• Tailoring for specific roles\n\nWhat aspect would you like to focus on?";
    } else if (message.contains('interview')) {
      return "Great! Interview prep is key to success. I can guide you through:\n\n• Common interview questions & answers\n• STAR method for behavioral questions\n• Company research strategies\n• Post-interview follow-up\n\nWhat type of interview are you preparing for?";
    } else if (message.contains('skills') || message.contains('learn')) {
      return "Skill development is essential for career growth! I can help you identify:\n\n• In-demand technical skills\n• Essential soft skills\n• Learning resources & platforms\n• Certification programs\n\nWhat field or skills are you interested in developing?";
    } else if (message.contains('hello') || message.contains('hi') || message.contains('hey')) {
      return "Hello there! Welcome to Career Navigator. I'm excited to help you advance your career. Whether you're job searching, planning your next move, or developing new skills, I'm here to guide you. What brings you here today?";
    } else if (message.contains('thank')) {
      return "You're very welcome! I'm always here to help with your career questions. Feel free to ask anything about job searching, career development, or professional growth anytime!";
    } else {
      return "That's an interesting question! While I specialize in career guidance, I'm always happy to help. Could you tell me more about your career goals or challenges? I can provide personalized advice based on your situation.";
    }
  }

  void clearChat() {
    state = [
      ChatMessage(
        text: "Hi! I'm your Career Navigator AI assistant. I'm here to help you with career planning, job search, resume tips, and interview preparation. What would you like to know?",
        isUser: false,
        timestamp: DateTime.now(),
      ),
    ];
  }
}

class ChatbotScreen extends ConsumerStatefulWidget {
  const ChatbotScreen({super.key});

  @override
  ConsumerState<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends ConsumerState<ChatbotScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isTyping = false;

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final message = _messageController.text.trim();
    if (message.isEmpty) return;

    ref.read(chatMessagesProvider.notifier).sendMessage(message);
    _messageController.clear();

    setState(() {
      _isTyping = true;
    });

    // Hide typing indicator after bot responds
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) {
        setState(() {
          _isTyping = false;
        });
        _scrollToBottom();
      }
    });

    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(chatMessagesProvider);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Row(
          children: [
            Icon(
              Icons.psychology,
              color: Colors.white,
              size: 24,
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Career Assistant',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'AI Career Guide',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            context.go('/');
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded, color: Colors.white),
            onPressed: () {
              ref.read(chatMessagesProvider.notifier).clearChat();
              setState(() {
                _isTyping = false;
              });
            },
            tooltip: 'New Conversation',
          ),
        ],
      ),
      body: Column(
        children: [
          // Chat messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: messages.length + (_isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == messages.length && _isTyping) {
                  return _buildTypingIndicator();
                }

                final message = messages[index];
                return _buildMessageBubble(message);
              },
            ),
          ),

          // Message input
          _buildMessageInput(),
        ],
      ),
      // Use your custom navigation bar
      bottomNavigationBar: const CustomNavBar(currentIndex: 1), // Chat is index 1
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isUser) ...[
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.blue[100],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.psychology,
                size: 16,
                color: Colors.blue[700],
              ),
            ),
            const SizedBox(width: 8),
          ],

          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: message.isUser ? Colors.blue[600] : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                message.text,
                style: GoogleFonts.inter(
                  color: message.isUser ? Colors.white : Colors.grey[800],
                  fontSize: 15,
                  height: 1.4,
                ),
              ),
            ),
          ),

          if (message.isUser) ...[
            const SizedBox(width: 8),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.person,
                size: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.blue[100],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.psychology,
              size: 16,
              color: Colors.blue[700],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Typing',
                  style: GoogleFonts.inter(
                    color: Colors.grey[600],
                    fontSize: 15,
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[400]!),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey[200]!),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TextField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    hintText: 'Ask me about your career...',
                    hintStyle: GoogleFonts.inter(
                      color: Colors.grey[500],
                      fontSize: 15,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                  style: GoogleFonts.inter(fontSize: 15),
                  onSubmitted: (_) => _sendMessage(),
                  textCapitalization: TextCapitalization.sentences,
                ),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: _sendMessage,
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.blue[600],
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.send_rounded,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}