shader_type spatial;
render_mode unshaded;

uniform float rain_amount = 200.0;
uniform float near_rain_length : hint_range(0.01, 1.0) = 0.2;
uniform float far_rain_length : hint_range(0.01, 1.0) = 0.1;
uniform float near_rain_width : hint_range(0.1, 1.0) = 1.0;
uniform float far_rain_width : hint_range(0.1, 1.0) = 0.5;
uniform float near_rain_transparency : hint_range(0.1, 1.0) = 1.0;
uniform float far_rain_transparency : hint_range(0.1, 1.0) = 0.5;

uniform vec4 rain_color : source_color = vec4(0.8, 0.8, 0.8, 1.0);
uniform float base_rain_speed : hint_range(0.1, 1.0) = 0.5;
uniform float additional_rain_speed : hint_range(0.1, 1.0) = 0.5;
uniform float slant : hint_range(-1.0, 1.0) = 0.2;

void fragment() {
    vec2 uv = UV;
    float time = TIME + 10000.0;

    float remainder = mod(uv.x - uv.y * slant, 1.0 / rain_amount);
    uv.x = (uv.x - uv.y * slant) - remainder;
    float rn = fract(sin(uv.x * rain_amount));
    uv.y = fract(uv.y + rn);

    float drop = step(1.0 - (far_rain_length + (near_rain_length - far_rain_length) * rn),
                      fract(uv.y - time * (base_rain_speed + additional_rain_speed * rn)));

    float fade = (far_rain_transparency + (near_rain_transparency - far_rain_transparency) * rn);
    float drop_width = step(remainder * rain_amount,
                            far_rain_width + (near_rain_width - far_rain_width) * rn);

    ALBEDO = mix(vec3(0.0), rain_color.rgb, drop * fade * drop_width);
    ALPHA = drop * fade * drop_width;
}
