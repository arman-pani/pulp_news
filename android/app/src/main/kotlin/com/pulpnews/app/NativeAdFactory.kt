package com.pulpnews.app

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.widget.Button
import android.widget.ImageView
import android.widget.TextView
import com.google.android.gms.ads.nativead.MediaView
import com.google.android.gms.ads.nativead.NativeAd
import com.google.android.gms.ads.nativead.NativeAdView
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin.NativeAdFactory

class NativeAdFactory(private val context: Context) : NativeAdFactory {
    
    override fun createNativeAd(nativeAd: NativeAd, customOptions: MutableMap<String, Any>?): NativeAdView {
        val nativeAdView = LayoutInflater.from(context)
            .inflate(R.layout.native_ad_layout, null) as NativeAdView

        // Set the media view
        nativeAdView.mediaView = nativeAdView.findViewById(R.id.ad_media)

        // Set other ad assets
        nativeAdView.headlineView = nativeAdView.findViewById(R.id.ad_headline)
        nativeAdView.bodyView = nativeAdView.findViewById(R.id.ad_body)
        nativeAdView.callToActionView = nativeAdView.findViewById(R.id.ad_call_to_action)
        nativeAdView.iconView = nativeAdView.findViewById(R.id.ad_app_icon)
        nativeAdView.advertiserView = nativeAdView.findViewById(R.id.ad_advertiser)

        // The headline is guaranteed to be in every NativeAd
        (nativeAdView.headlineView as? TextView)?.text = nativeAd.headline

        // Set media content if available
        nativeAd.mediaContent?.let { mediaContent ->
            nativeAdView.mediaView?.setMediaContent(mediaContent)
            nativeAdView.mediaView?.visibility = View.VISIBLE
        } ?: run {
            nativeAdView.mediaView?.visibility = View.GONE
        }

        // These assets aren't guaranteed to be in every NativeAd, so check before displaying
        if (nativeAd.body == null) {
            nativeAdView.bodyView?.visibility = View.INVISIBLE
        } else {
            nativeAdView.bodyView?.visibility = View.VISIBLE
            (nativeAdView.bodyView as? TextView)?.text = nativeAd.body
        }

        if (nativeAd.callToAction == null) {
            nativeAdView.callToActionView?.visibility = View.INVISIBLE
        } else {
            nativeAdView.callToActionView?.visibility = View.VISIBLE
            (nativeAdView.callToActionView as? Button)?.text = nativeAd.callToAction
        }

        if (nativeAd.icon == null) {
            nativeAdView.iconView?.visibility = View.GONE
        } else {
            (nativeAdView.iconView as? ImageView)?.setImageDrawable(nativeAd.icon?.drawable)
            nativeAdView.iconView?.visibility = View.VISIBLE
        }

        if (nativeAd.advertiser == null) {
            nativeAdView.advertiserView?.visibility = View.INVISIBLE
        } else {
            nativeAdView.advertiserView?.visibility = View.VISIBLE
            (nativeAdView.advertiserView as? TextView)?.text = nativeAd.advertiser
        }

        // This method tells the Google Mobile Ads SDK that you have finished populating your native ad view
        nativeAdView.setNativeAd(nativeAd)

        return nativeAdView
    }
}