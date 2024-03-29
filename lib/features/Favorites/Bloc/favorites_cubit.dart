import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutez/core/cache_helper/cache_helper.dart';
import 'package:flutez/core/cache_helper/cache_values.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Track/Model/track_model.dart';
import 'favorites_states.dart';

class FavoritesCubit extends Cubit<FavoritesStates> {
  FavoritesCubit() : super(FavoritesInitial());
  static FavoritesCubit get(context) => BlocProvider.of(context);

  List<Track> favorites = [];

  Future<void> getFavorites() async {
    FirebaseFirestore.instance
        .collection("Users")
        .doc(CacheHelper.getData(key: CacheKeys.uId))
        .collection("Favorites")
        .snapshots()
        .listen((value) {
      favorites = [];
      for (var element in value.docs) {
        favorites.add(Track.fromJson(element.data()));
      }
      emit(GetFavoritesSuccessState());
    }).onError((error) {
      print(error.toString());
      emit(GetFavoritesErrorState());
    });
  }

  Future<void> addToFav(Track track) async {
    FirebaseFirestore.instance
        .collection("Users")
        .doc(CacheHelper.getData(key: CacheKeys.uId))
        .collection("Favorites")
        .add(track.toJson()).then((value) {
          emit(AddFavoriteSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(AddFavoriteErrorState());
    });
  }

  Future<void> removeFromFav(link) async {
    FirebaseFirestore.instance
        .collection("Users")
        .doc(CacheHelper.getData(key: CacheKeys.uId))
        .collection("Favorites")
        .where("trackLink",isEqualTo:link ).get().then((value) {
          for (var element in value.docs) {
            element.reference.delete();
          }
    }).then((value) {
      emit(RemoveFavoriteSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(RemoveFavoriteErrorState());
    });
  }

  bool inFav(Track track){
    if(favorites.contains(track)){
      return true;
    }else{
      return false;
    }
    // for (var element in favorites) {
    //   if(element == track){
    //     return true;
    //   }
    // }
    // return false;
  }
}
