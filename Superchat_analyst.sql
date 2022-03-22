/****** Check distinct englishName ******/
SELECT [englishName] , count(*)
      
  FROM [projecthololive].[dbo].[channels$]
 group by [englishName]
 having count(*) >1

 /**** check name 'Kizuna AI'****/
 SELECT *
      
  FROM [projecthololive].[dbo].[channels$]
 where [englishName] = 'Kizuna AI'

 /*** check name 'machiro'***/
  SELECT *
      
  FROM [projecthololive].[dbo].[channels$]
 where [englishName] = 'Mashiro' /**different people***/

 /***[name] is primary key have 1081 rows***/
 SELECT *
      from [projecthololive].[dbo].[channels$]

	   
  /**** create table inner join table superchat_stats & chanels then import to excel***/
  select ch.[channelId],[period] ,[englishName], [group] , [subscriptionCount] , [affiliation] ,[videoCount] ,[totalSC]
  into inner_sc_ch
  from [projecthololive].[dbo].[superchat_stats$] as sc
  Inner join [projecthololive].[dbo].[channels$] as ch
  on sc.channelId = ch.channelId
  /**** order subcount desc analyst table inner_sc_ch***/

  SELECT [channelId] , sum(totalSC) as 'totalsc_2021-04_to_2022-02'
      from [projecthololive].[dbo].[inner_sc_ch]
	  group by [channelId] 
	  order by sum(totalSC) desc
	 


