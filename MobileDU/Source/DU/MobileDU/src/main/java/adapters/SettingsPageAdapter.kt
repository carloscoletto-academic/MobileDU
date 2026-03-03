package adapters

import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment
import androidx.viewpager2.adapter.FragmentStateAdapter
import fragments.ContrastSettingsFragment
import fragments.EnvironmentSettingsFragment
import fragments.TextSettingsFragment
import fragments.SoundSettingsFragment

class SettingsPagerAdapter(activity: AppCompatActivity) : FragmentStateAdapter(activity) {
    override fun getItemCount(): Int = 4

    override fun createFragment(position: Int): Fragment {
        return when (position) {
            0 -> TextSettingsFragment()           // Texto
            1 -> EnvironmentSettingsFragment()    // Ambiente
            2 -> SoundSettingsFragment()          // Som
            3 -> ContrastSettingsFragment()       // Contraste

//            4 -> VideoSettingsFragment()          // Vídeo
//            5 -> InputSettingsFragment()          // Entrada
//            6 -> NotificationsSettingsFragment()  // Notificações
//            7 -> GestureSettingsFragment()       // Gestos
            else -> Fragment()
        }
    }
}
