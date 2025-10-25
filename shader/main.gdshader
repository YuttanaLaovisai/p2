shader_type canvas_item;

uniform sampler2D screen_tex : hint_screen_texture;

// 🎨 Black & White
uniform bool force_grayscale = true;
uniform float darkness : hint_range(0.0, 2.0) = 0.35; // ✅ ความมืด
uniform float contrast : hint_range(0.0, 3.0) = 1.2;  // ✅ คอนทราสต์

// 📼 Noise
uniform float noise_strength : hint_range(0.0, 1.0) = 0.25;
uniform float noise_scale : hint_range(1.0, 100.0) = 50.0;
uniform float time_speed : hint_range(0.0, 5.0) = 2.0;

// 📊 Scanline
uniform float scanline_strength : hint_range(0.0, 0.5) = 0.08;

// 🌑 Vignette (หนักขึ้น)
uniform float vignette_strength : hint_range(0.0, 3.0) = 1.4;

void fragment() {
    vec2 uv = UV;
    vec4 col = texture(screen_tex, uv);

    // ✅ บังคับขาวดำ
    float gray = (col.r + col.g + col.b) / 3.0;
    col.rgb = vec3(gray);

    // ✅ ปรับคอนทราสต์ (ทำให้โทนดำ-ขาวต่างชัดขึ้น)
    col.rgb = (col.rgb - 0.5) * contrast + 0.5;

    // ✅ ทำให้มืดลง
    col.rgb *= (1.0 - darkness);

    // ✅ Noise film
    float noise = fract(sin(dot(uv * vec2(TIME * time_speed, TIME * 0.9) * noise_scale,
                      vec2(12.9898, 78.233))) * 43758.5453);
    col.rgb = mix(col.rgb, vec3(noise), noise_strength);

    // ✅ Scanline
    float scan = sin(UV.y * 900.0);
    col.rgb -= scanline_strength * scan;

    // ✅ Vignette หนักขึ้น ล้อมขอบมืด
    vec2 pos = uv - vec2(0.5);
    float vignette = smoothstep(0.5, vignette_strength + 0.5, length(pos));
    col.rgb *= (1.0 - vignette * vignette_strength);

    COLOR = col;
}
