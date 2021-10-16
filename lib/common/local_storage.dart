import 'enums/local_storage_type_enum.dart';
import 'local_storage_file.dart';

class LocalStorage {
  LocalStorageType? _type;
  LocalStorageByFile saveFile = LocalStorageByFile();

  LocalStorage([type]) {
    if (type == null) {
      this._type = LocalStorageType.file;
    } else {
      this._type = type;
    }
  }

  Future<String?> readLocal() async {
    String? result;
    switch (this._type) {
      case LocalStorageType.file:
        result = await saveFile.readContents();
        break;

      case LocalStorageType.sqlite:
        break;

      default:
        break;
    }

    return result;
  }

  Future<void> writeLocal(String contents) async {
    switch (this._type) {
      case LocalStorageType.file:
        await saveFile.writeContents(contents);
        break;

      case LocalStorageType.sqlite:
        break;

      default:
        break;
    }
  }
}
