shader_type canvas_item;

// Define a uniform variable to select the color you want to remove
// hint_color makes it a color picker in the Inspector
uniform vec4 ChromaKey : source_color;

void fragment() {
    // Get the color of the current pixel from the texture
    vec4 color = texture(TEXTURE, UV);

    // Check if the pixel's color is the same as the ChromaKey color
    if (color.rgb == ChromaKey.rgb) {
        // If it matches, set the alpha (transparency) to 0.0 (fully transparent)
        color.a = 0.0;
    }

    // Assign the potentially modified color (including new alpha) back to the output
    COLOR = color;
}
