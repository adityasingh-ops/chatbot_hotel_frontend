import 'package:chatbot_hotel/Common/custom_app_bar.dart';
import 'package:chatbot_hotel/Common/custom_container.dart';
import 'package:chatbot_hotel/chat_screen.dart';
import 'package:chatbot_hotel/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class MainScreen extends StatelessWidget {
   MainScreen({super.key});

    final List<Review> reviews = [
     Review(name: 'John Doe', rating: 4, comment: 'Great product!'),
     Review(name: 'Alice Smith', rating: 5, comment: 'Excellent service!'),
     Review(name: 'Bob Johnson', rating: 3, comment: 'Could be better.'),
   ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: kPrimary,
      appBar: PreferredSize(preferredSize: Size.fromHeight(130),child: CustomAppBar()),
      body: SafeArea(
        child:CustomContainer(
          containerContent: Column(
            children: [
              ImageSlider(),
              const SizedBox(height: 20,),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(reviews[index].name[0]),
                      ),
                      title: Text(reviews[index].name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildRatingStars(reviews[index].rating),
                          SizedBox(height: 4),
                          Text(reviews[index].comment),
                        ],
                      ),
                    ),
                  );
                },
        ),
      
            ],
          ),
          ),

          ),
          floatingActionButton: GestureDetector(
              
                onTap: (){
                  Get.to(()=> ChatScreen());
                },
                child: CircleAvatar(
                    
                    radius: 50,
                    backgroundColor: kSecondary,
                    backgroundImage: AssetImage("assets/anime/chat.avif"),
                  ),
              ),
    );
  }
   Widget _buildRatingStars(int rating) {
    List<Widget> stars = [];
    for (int i = 0; i < 5; i++) {
      IconData iconData = i < rating ? Icons.star : Icons.star_border;
      Color color = i < rating ? Colors.orange : Colors.grey;
      stars.add(Icon(iconData, color: color));
    }
    return Row(children: stars);
  }
}




class ImageSlider extends StatelessWidget {
  final List<String> imageUrls = [
    'https://images.pexels.com/photos/271624/pexels-photo-271624.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/258154/pexels-photo-258154.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/189296/pexels-photo-189296.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/338504/pexels-photo-338504.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/2017802/pexels-photo-2017802.jpeg?auto=compress&cs=tinysrgb&w=600',
  ];

  @override
   Widget build(BuildContext context) {
    return SizedBox(
      height: 200.0, // Set the height for the image slider
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              imageUrls[index],
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}

class Review {
  final String name;
  final int rating;
  final String comment;

  Review({required this.name, required this.rating, required this.comment});
}


