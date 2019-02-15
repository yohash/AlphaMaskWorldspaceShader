Shader "Alpha Mask/Worldspace-Unlit"
{
    Properties
		{
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Mask ("Mask (A)", 2D) = "white" {}
    }
    SubShader
		{
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Lambert fullforwardshadows addshadow alpha
        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _Mask;

        float4 _MainTex_ST;
				fixed4 _Color;

        struct Input {
            float2 uv_MainTex;
            float2 uv_Mask;
            float3 worldNormal;
            float3 worldPos;
        };

        void surf (Input IN, inout SurfaceOutput o)
				{
            o.Alpha = tex2D (_Mask, IN.uv_Mask).a;

            if(abs(IN.worldNormal.y) > 0.5)
            {
                o.Emission = tex2D(_MainTex, IN.worldPos.xz * float2(_MainTex_ST.x, _MainTex_ST.y)) * _Color;
            }
            else if(abs(IN.worldNormal.x) > 0.5)
            {
                o.Emission = tex2D(_MainTex, IN.worldPos.yz * float2(_MainTex_ST.x, _MainTex_ST.y)) * _Color;
            }
            else
            {
                o.Emission = tex2D(_MainTex, IN.worldPos.xy * float2(_MainTex_ST.x, _MainTex_ST.y)) * _Color;
            }
        }
        ENDCG
    }
    FallBack "Diffuse"
}
