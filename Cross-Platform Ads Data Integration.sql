with facebook_data as(
select 
		fabd.ad_date,
		fc.campaign_name,
		fa.adset_name,
		fabd.spend,
		fabd.impressions,
		fabd.reach,
		fabd.clicks,
		fabd.leads,
		fabd.value
from facebook_ads_basic_daily as fabd
	join facebook_adset as fa
		on fabd.adset_id = fa.adset_id
	join facebook_campaign as fc
		on fabd.campaign_id = fc.campaign_id),

google_and_facebook_data as(
select 
		ad_date,
		'Facebook Ads' as media_source,
		campaign_name,
		adset_name,
		spend,
		impressions,
		clicks,
		value
from facebook_data
union
select 
		ad_date,
		'Google Ads' as media_source,
		campaign_name,
		null as adset_name,
		spend,
		impressions,
		clicks,
		value
from google_ads_basic_daily)

select 
		ad_date,
		media_source,
		campaign_name,
		adset_name,
		sum(spend) as total_spend,
		sum(impressions) as total_impressions,
		sum(clicks) as total_clicks,
		sum(value) as total_conversion_value
from google_and_facebook_data
group by 
		ad_date,
		media_source,
		campaign_name,
		adset_name,ad_date 
order by 
		ad_date,
		media_source;