using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Cycle : MonoBehaviour
{
    public float frequency;
    public float radius;

    void Update()
    {
        float x = Mathf.Sin(frequency * Time.time) * radius;
        float y = Mathf.Cos(frequency * Time.time) * radius;

        gameObject.transform.position = new Vector3(x, y, 0f);
    }
}
