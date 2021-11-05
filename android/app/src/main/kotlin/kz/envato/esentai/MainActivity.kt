package kz.envato.esentai

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import com.yandex.mapkit.MapKitFactory

class MainActivity: FlutterActivity() {

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        MapKitFactory.setApiKey("9377ab8d-815d-487c-a5c4-2353c824e3fe")
        MapKitFactory.setLocale("ru_RU")
        super.configureFlutterEngine(flutterEngine)
    }
    
}
