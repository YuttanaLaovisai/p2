shader_type canvas_item;

uniform sampler2D screen_tex : hint_screen_texture;

// 🎨 Color Adjust
uniform float desaturation : hint_range(0.0, 1.0) = 0.5;
uniform float sepia_strength : hint_range(0.0, 1.0) = 0.4;

// 📼 Noise
uniform float noise_strength : hint_range(0.0, 1.0) = 0.25;
uniform float noise_scale : hint_range(1.0, 100.0) = 50.0;
uniform float time_speed : hint_range(0.0, 5.0) = 2.0;

// 📊 Scanline
uniform float scanline_strength : hint_range(0.0, 0.5) = 0.05;

// 🌑 Vignette
uniform float vignette_strength : hint_range(0.0, 2.0) = 0.8;

void fragment() {
    vec2 uv = UV;
    vec4 col = texture(screen_tex, uv);

    // Desaturation
    float gray = (col.r + col.g + col.b) / 3.0;
    col.rgb = mix(col.rgb, vec3(gray), desaturation);

    // Sepia
    vec3 sepia = vec3(
        col.r * 0.393 + col.g * 0.769 + col.b * 0.189,
        col.r * 0.349 + col.g * 0.686 + col.b * 0.168,
        col.r * 0.272 + col.g * 0.534 + col.b * 0.131
    );
    col.rgb = mix(col.rgb, sepia, sepia_strength);

    // Noise
    float noise = fract(sin(dot(uv * vec2(TIME * time_speed, TIME * 0.9) * noise_scale,
                      vec2(12.9898, 78.233))) * 43758.5453);
    col.rgb = mix(col.rgb, vec3(noise), noise_strength);

    // Scanline
    float scan = sin(UV.y * 800.0);
    col.rgb -= scanline_strength * scan;

    // Vignette
    vec2 pos = uv - vec2(0.5);
    float vignette = smoothstep(0.6, vignette_strength + 0.6, length(pos));
    col.rgb *= (1.0 - vignette * vignette_strength);

    COLOR = col;
}
