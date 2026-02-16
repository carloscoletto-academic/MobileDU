
package fragments

import android.graphics.Color
import android.graphics.drawable.GradientDrawable
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.TextView
import android.widget.Toast
import androidx.core.view.children
import androidx.fragment.app.Fragment
import com.mobile.mobiledu.R
import config.AppConfig

class ContrastSettingsFragment : Fragment() {

    private lateinit var preview: TextView
    private lateinit var contrastRoot: ViewGroup
    private var selectedButton: Button? = null
    private var selectedBgColor: Int = Color.WHITE
    private var selectedFgColor: Int = Color.BLACK

    private val contrastOptions = listOf(
        Triple("Preto no Branco", "#FFFFFF", "#000000"),
        Triple("Branco no Preto", "#000000", "#FFFFFF"),
        Triple("Branco no Azul Escuro", "#003366", "#FFFFFF"),
        Triple("Amarelo no Cinza Escuro", "#2E2E2E", "#FFFF99"),
        Triple("Branco no Verde Escuro", "#004400", "#FFFFFF")
    )

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return inflater.inflate(R.layout.fragment_contrast_settings, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        preview = view.findViewById(R.id.viewContrastPreview)
        contrastRoot = view.findViewById(R.id.contrastRoot)
        val btnSave = view.findViewById<Button>(R.id.btnSaveContrast)
        val btnCancel = view.findViewById<Button>(R.id.btnCancelContrast)

        contrastOptions.forEachIndexed { index, (label, bgColorHex, textColorHex) ->
            val btn = Button(requireContext()).apply {
                text = label
                setBackgroundColor(Color.parseColor(bgColorHex))
                setTextColor(Color.parseColor(textColorHex))
                textSize = 18f
                setPadding(16, 16, 16, 16)
                setOnClickListener { onContrastSelected(this, bgColorHex, textColorHex) }
                layoutParams = ViewGroup.MarginLayoutParams(
                    ViewGroup.LayoutParams.MATCH_PARENT,
                    180
                    //ViewGroup.LayoutParams.WRAP_CONTENT
                ).apply {
                    bottomMargin = 16
                }
            }

            contrastRoot.addView(btn, contrastRoot.childCount - 2) // insere antes do preview e dos botões de ação
        }

        btnSave.setOnClickListener {
            AppConfig.color = selectedBgColor
            AppConfig.textColor = selectedFgColor
            AppConfig.save(requireContext())
            Toast.makeText(requireContext(), "Contraste salvo!", Toast.LENGTH_SHORT).show()
            requireActivity().finish()
        }

        btnCancel.setOnClickListener {
            requireActivity().onBackPressedDispatcher.onBackPressed()
        }
    }

    private fun onContrastSelected(button: Button, bgColorHex: String, textColorHex: String) {
        selectedButton?.background = GradientDrawable().apply {
            setColor((selectedButton?.background as? GradientDrawable)?.color?.defaultColor ?: Color.TRANSPARENT)
            cornerRadius = 8f
        }

        selectedButton = button
        selectedBgColor = Color.parseColor(bgColorHex)
        selectedFgColor = Color.parseColor(textColorHex)

        // Atualiza preview
        preview.setBackgroundColor(selectedBgColor)
        preview.setTextColor(selectedFgColor)

        // Adiciona borda preta ao botão selecionado
        val border = GradientDrawable().apply {
            setColor(selectedBgColor)
            setStroke(8, Color.RED)
            cornerRadius = 8f
        }
        button.background = border
    }
}
