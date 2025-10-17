import 'package:odiya_news_app/models/news_model.dart';

class DataSource {
   final newsArticle = NewsModel(
          id: "otet-exam-2025",
          sourceName: "OdishaTV",
          sourceUrl: "https://odishatv.in",
          title: "OTET ପରୀକ୍ଷା: 75,000 ଶିକ୍ଷକ ପାଇଁ ଆବଶ୍ୟକୀୟ ପରୀକ୍ଷା",
          author: "OTV Desk",
          publishedAt: DateTime.now(),
          imageUrl:
              "https://img-cdn.publive.online/fit-in/1280x960/filters:format(webp)/odishatv/media/post_attachments/uploadimage/library/16_9/16_9_0/OTET_1617968102.jpg",
          content:
              "ଆଜି ରାଜ୍ୟରେ 75,000ରୁ ଅଧିକ ପ୍ରାଥମିକ ଶିକ୍ଷକ OTET ପରୀକ୍ଷା ଦେଉଛନ୍ତି। ପେପର ଲିକ୍ ପରେ ପୂର୍ବତନ ପରୀକ୍ଷା ବାତିଲ ହୋଇଥିଲା। ବହୁ ସ୍କୁଲ୍‌ରେ ଶିକ୍ଷକ ସଙ୍କଟ ସୃଷ୍ଟି ହୋଇଥିବାରୁ ପରିଚାଳନାରେ ଅସୁବିଧା ସୃଷ୍ଟି ହୋଇଛି। ସରକାର ଜରୁରୀୟଭାବରେ ଅନ୍ୟ ସ୍କୁଲ୍‌ରୁ ଶିକ୍ଷକଙ୍କୁ ଯୋଗାଣ କରିଛି। ପରୀକ୍ଷାର ସୁରକ୍ଷା ବ୍ୟବସ୍ଥା ବଳବତ୍ତ କରାଯାଇଛି ଏବଂ BSE ଅଧିକାରୀମାନଙ୍କୁ ପରିବର୍ତ୍ତନ କରାଯାଇଛି।",
          category: "Education",
          createdAt: DateTime.now().toString(),
        );
  static List<NewsModel> getNews() {
    return [
      NewsModel(
        id: "100",
        title: 'Russia Beauty the spread of the war',
        content:
            'Russia has been accused of using chemical weapons in its ongoing conflict with Ukraine, leading to widespread condemnation from the international community. The use of such weapons is a violation of international law and has raised concerns about the humanitarian impact on civilians caught in the crossfire.',
        imageUrl: 'https://picsum.photos/200/300',
        category: 'BUSINESS',
        author: 'Arman Pani',
        sourceName: 'NDTV',
        sourceUrl: 'https://ndtv.com',
        createdAt: DateTime.now().subtract(Duration(hours: 1)).toString(),
        publishedAt: DateTime.now().subtract(Duration(hours: 1)),
      ),
      NewsModel(
        id: "101",

        title: 'Tech Giants Face Scrutiny Over Data Privacy',
        content:
            'Major technology companies are under increasing pressure to enhance data privacy measures as concerns about user data security grow.',
        imageUrl: 'https://picsum.photos/200/300',
        category: 'TECHNOLOGY',
        author: 'Jane Doe',
        sourceName: 'TechCrunch',
        sourceUrl: 'https://techcrunch.com',
        createdAt: DateTime.now().subtract(Duration(hours: 2)).toString(),
        publishedAt: DateTime.now().subtract(Duration(hours: 2)),
      ),
      NewsModel(
        id: "102",

        title: 'Tech Giants Face Scrutiny Over Data Privacy',
        content:
            'Major technology companies are under increasing pressure to enhance data privacy measures as concerns about user data security grow.',
        imageUrl: 'https://picsum.photos/200/300',
        category: 'TECHNOLOGY',
        author: 'Jane Doe',
        sourceName: 'TechCrunch',
        sourceUrl: 'https://techcrunch.com',
        createdAt: DateTime.now().subtract(Duration(hours: 2)).toString(),
        publishedAt: DateTime.now().subtract(Duration(hours: 2)),
      ),
      NewsModel(
        id: "103",

        title: 'Russia Beauty the spread of the war',
        content:
            'Russia has been accused of using chemical weapons in its ongoing conflict with Ukraine, leading to widespread condemnation from the international community. The use of such weapons is a violation of international law and has raised concerns about the humanitarian impact on civilians caught in the crossfire.',
        imageUrl: 'https://picsum.photos/200/300',
        category: 'BUSINESS',
        author: 'Arman Pani',
        sourceName: 'NDTV',
        sourceUrl: 'https://ndtv.com',
        createdAt: DateTime.now().subtract(Duration(hours: 1)).toString(),
        publishedAt: DateTime.now().subtract(Duration(hours: 1)),
      ),
      NewsModel(
        id: "104",

        title: 'Russia Beauty the spread of the war',
        content:
            'Russia has been accused of using chemical weapons in its ongoing conflict with Ukraine, leading to widespread condemnation from the international community. The use of such weapons is a violation of international law and has raised concerns about the humanitarian impact on civilians caught in the crossfire.',
        imageUrl: 'https://picsum.photos/200/300',
        category: 'BUSINESS',
        author: 'Arman Pani',
        sourceName: 'NDTV',
        sourceUrl: 'https://ndtv.com',
        createdAt: DateTime.now().subtract(Duration(hours: 1)).toString(),
        publishedAt: DateTime.now().subtract(Duration(hours: 1)),
      ),
      NewsModel(
        id: "105",

        title: 'Russia Beauty the spread of the war',
        content:
            'Russia has been accused of using chemical weapons in its ongoing conflict with Ukraine, leading to widespread condemnation from the international community. The use of such weapons is a violation of international law and has raised concerns about the humanitarian impact on civilians caught in the crossfire.',
        imageUrl: 'https://picsum.photos/200/300',
        category: 'BUSINESS',
        author: 'Arman Pani',
        sourceName: 'NDTV',
        sourceUrl: 'https://ndtv.com',
        createdAt: DateTime.now().subtract(Duration(hours: 1)).toString(),
        publishedAt: DateTime.now().subtract(Duration(hours: 1)),
      ),
      NewsModel(
        id: "106",

        title: 'Tech Giants Face Scrutiny Over Data Privacy',
        content:
            'Major technology companies are under increasing pressure to enhance data privacy measures as concerns about user data security grow.',
        imageUrl: 'https://picsum.photos/200/300',
        category: 'TECHNOLOGY',
        author: 'Jane Doe',
        sourceName: 'TechCrunch',
        sourceUrl: 'https://techcrunch.com',
        createdAt: DateTime.now().subtract(Duration(hours: 2)).toString(),
        publishedAt: DateTime.now().subtract(Duration(hours: 2)),
      ),
      NewsModel(
        id: "107",

        title: 'Tech Giants Face Scrutiny Over Data Privacy',
        content:
            'Major technology companies are under increasing pressure to enhance data privacy measures as concerns about user data security grow.',
        imageUrl: 'https://picsum.photos/200/300',
        category: 'TECHNOLOGY',
        author: 'Jane Doe',
        sourceName: 'TechCrunch',
        sourceUrl: 'https://techcrunch.com',
        createdAt: DateTime.now().subtract(Duration(hours: 2)).toString(),
        publishedAt: DateTime.now().subtract(Duration(hours: 2)),
      ),
      NewsModel(
        id: "108",

        title: 'Russia Beauty the spread of the war',
        content:
            'Russia has been accused of using chemical weapons in its ongoing conflict with Ukraine, leading to widespread condemnation from the international community. The use of such weapons is a violation of international law and has raised concerns about the humanitarian impact on civilians caught in the crossfire.',
        imageUrl: 'https://picsum.photos/200/300',
        category: 'BUSINESS',
        author: 'Arman Pani',
        sourceName: 'NDTV',
        sourceUrl: 'https://ndtv.com',
        createdAt: DateTime.now().subtract(Duration(hours: 1)).toString(),
        publishedAt: DateTime.now().subtract(Duration(hours: 1)),
      ),
      NewsModel(
        id: "109",

        title: 'Russia Beauty the spread of the war',
        content:
            'Russia has been accused of using chemical weapons in its ongoing conflict with Ukraine, leading to widespread condemnation from the international community. The use of such weapons is a violation of international law and has raised concerns about the humanitarian impact on civilians caught in the crossfire.',
        imageUrl: 'https://picsum.photos/200/300',
        category: 'BUSINESS',
        author: 'Arman Pani',
        sourceName: 'NDTV',
        sourceUrl: 'https://ndtv.com',
        createdAt: DateTime.now().subtract(Duration(hours: 1)).toString(),
        publishedAt: DateTime.now().subtract(Duration(hours: 1)),
      ),
    ];
  }
}
