import '../models/list_bank_model.dart';
import '../models/rekening_favorit_model.dart';
import '../models/rekening_transfer_model.dart';
List<RekFavModel> globalListFavorit = [];
List<RekFavModel> globalListFavoritWM = [];
List<RekFavModel> globalListFavoritOther = [];
List<ListBankModel> globalListBankLain = [];
List<RekeningForTransferModel> globalListRekeningTransfer = [];
List globalListRekening = [];
bool cekVersionApk = false;
String versionApkDB = '';
List<String> imagesBanner = [];
String kodeBiodata = '';
String localName = '';
String localEmail = '';
String localUsername = '';
String localPassword = '';
String localNomorTelp = '';
String localCreateDate = '';
List<String> tujuanPenggunaan = [];
Map<String, List<String>> dataTujuanPenggunaan = {};
String syaratPendaftaran = '';
String tokenUser = '';