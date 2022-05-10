
import 'package:get/get.dart';
import 'package:kabtv/constants.dart';
import 'package:kabtv/model/Model.dart';
import 'package:kabtv/model/Modelclass.dart';
import 'package:kabtv/service/remoteService.dart';

class AppDetailsController extends GetxController {
  var isLoading = true.obs;
  var DataAll =<Dataitem>[].obs;
  var Audiotheques =<Dataitem>[].obs;
  var Videotheques =<Dataitem>[].obs;
  var Activites=<Dataitem>[].obs;
  var Didacticiels=<Dataitem>[].obs;
  var Membres=<Dataitem>[].obs;
  var Derniersaudios=<Dataitem>[].obs;
  var Emissions=<Dataitem>[].obs;
  var Audios=<Dataitem>[].obs;
  var Direct=new ModelClass(title: '',desc: '',feedUrl: '',sdimage: '',streamUrl: '',type: '');
  var Radio=new ModelClass(title: '',desc: '',feedUrl: '',sdimage: '',streamUrl: '',type: '');

  @override
  void onInit() {
    fetchAllData(url);
    super.onInit();
  }

  void fetchAllData(String url) async{
    try {
      isLoading(true);
      var allitems = await RemoteServices.fetchDataAll(url);
      if(allitems !=null){
        DataAll.value=allitems;
        allitems.forEach((element) async {
          if(element.title=="Audiotheque"){
            var allaudios = await RemoteServices.fetchDataAll(element.feedUrl);
            if(allaudios!=null){
              Audiotheques.value=allaudios;
            }
          }
          else if(element.title=="Videotheque"){
            var allaudios = await RemoteServices.fetchDataAll(element.feedUrl);
            if(allaudios!=null){
              Videotheques.value=allaudios;
            }

          }
          else if(element.title=="Derniers audios"){
            var allaudios = await RemoteServices.fetchDataAll(element.feedUrl);
            if(allaudios!=null){
              Derniersaudios.value=allaudios;
            }
          }
          else if(element.title=="Activités"){
            var allaudios = await RemoteServices.fetchDataAll(element.feedUrl);
            if(allaudios!=null){
              Activites.value=allaudios;
            }
          }
          else if(element.title=="Didacticiels"){
            var allaudios = await RemoteServices.fetchDataAll(element.feedUrl);
            if(allaudios!=null){
              Didacticiels.value=allaudios;
            }
          }
          else if(element.title=="Membres"){
            var allaudios = await RemoteServices.fetchDataAll(element.feedUrl);
            if(allaudios!=null){
              Membres.value=allaudios;
            }
          }
          else if(element.title=="Emissions TV"){
            var allaudios = await RemoteServices.fetchDataAll(element.feedUrl);
            if(allaudios!=null){
              Emissions.value=allaudios;
            }
          }
          else if(element.title=="Actualités"){

          }
          else if(element.title=="Direct RADIO"){
            Radio.title=element.title;
            Radio.desc=element.desc;
            Radio.type=element.type;
            Radio.feedUrl=element.feedUrl;
            Radio.sdimage=element.sdimage;
            Radio.streamUrl=element.streamUrl;
          }
          else if(element.title=="Direct TV"){
            Direct.title=element.title;
            Direct.desc=element.desc;
            Direct.type=element.type;
            Direct.feedUrl=element.feedUrl;
            Direct.sdimage=element.sdimage;
            Direct.streamUrl=element.streamUrl;
          }
        });
        //fetchVideoUrl('https://acanvod.acan.group/myapiv2/directplayback/33/json');
      }
    } finally {
      isLoading(false);
    }
  }


  void fetchAllAudios(String url) async{
    try{
      isLoading(true);
      var allitems = await RemoteServices.fetchDataAll(url);
      if(allitems !=null){
        Audios.value=allitems;

      }
    }
    finally {
      isLoading(false);
    }
  }

}