/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [channelId]
      ,[name]
      ,[englishName]
      ,[affiliation]
      ,[group]
      ,[subscriptionCount]
      ,[videoCount]
      ,[photo]
  FROM [projecthololive].[dbo].[channels$]

/******************************************Cleaning data process****************************************************/
  ---check Duplicates of [channelId] in table [dbo].[channels$]--
  select [channelId], count([channelId])
  from [projecthololive].[dbo].[channels$]
  group by [channelId]
  having count([channelId]) > 1

  ---check Duplicates of [channelId] in table [dbo].[superchat_stats$]--
  select [period], [channelId], count([channelId])
  from [projecthololive].[dbo].[superchat_stats$]
  group by [period] , [channelId]
  having count([channelId]) > 1

  --check null value for all column in [dbo].[superchat_stats$] table--
  select *
  from [projecthololive].[dbo].[superchat_stats$]
  where [channelId] is null
      or[period] is null
      or[superChats] is null
      or[uniqueSuperChatters] is null
      or[totalSC] is null
      or[averageSC] is null
      or[totalMessageLength] is null
      or[averageMessageLength] is null
      or[mostFrequentCurrency] is null
      or[mostFrequentColor] is null

  ---Create table inner join  [dbo].[channels$] and [dbo].[superchat_stats$] then select column that can use for analyst superchat---
  select sc.[channelId],[period],[superChats],[uniqueSuperChatters],[totalSC],[averageSC],[totalMessageLength],[averageMessageLength],[mostFrequentCurrency],[mostFrequentColor],[englishName],[affiliation],[group],[subscriptionCount],[videoCount]
  into Table_for_analyst_SC
  from [projecthololive].[dbo].[superchat_stats$] as sc
  inner join [projecthololive].[dbo].[channels$] as ch
  on sc.[channelId] = ch.[channelId]

  /*************************************Analyst Part******************************************/

  --select table for sc analyst--
  SELECT  [channelId]
      ,[period]
      ,[superChats]
      ,[uniqueSuperChatters]
      ,[totalSC]
      ,[averageSC]
      ,[totalMessageLength]
      ,[averageMessageLength]
      ,[mostFrequentCurrency]
      ,[mostFrequentColor]
      ,[englishName]
      ,[affiliation]
      ,[group]
      ,[subscriptionCount]
      ,[videoCount]
  FROM [projecthololive].[dbo].[Table_for_analyst_SC]
  
 

  ---check year----
  SELECT
      distinct[period]    
  FROM [projecthololive].[dbo].[Table_for_analyst_SC]
  order by [period]

  ---Calculate average superchat/person 2021/03-2022/02 (yyyy/mm)---
  select TOP 20 [channelId], sum([totalSC]) as TotalSC_all_year , avg([averageSC]) as avg_scCount_all_year , avg([superChats]/[uniqueSuperChatters]) as 'avg_Superchat/Person' ,[subscriptionCount]
  FROM [projecthololive].[dbo].[Table_for_analyst_SC]
  group by [channelId] , [subscriptionCount]
  order by sum([totalSC]) desc

  /------Check that each year [mostFrequentCurrency] Change or stay the same by comparing rows between select distinct[channelId] and select [channelId]. the result of row of test is same number(1140 rows)-----/
  select distinct[channelId] ,[mostFrequentCurrency] ,count([mostFrequentCurrency]) as Count_currency
  FROM [projecthololive].[dbo].[Table_for_analyst_SC]
  group by [channelId] , [mostFrequentCurrency]
  order by [channelId] xxxxxxxxxxxxxxxx

 /*******************************Part of Analyst affiliation**********************************/
  
  ----Check affiliation has more than one [mostFrequentCurrency] or not by comparing rows between select distinct[affiliation] and select [affiliation]. the result of row of test is same number(49 rows)---
  select distinct[affiliation] , count([mostFrequentCurrency])
  FROM [projecthololive].[dbo].[Table_for_analyst_SC]
  group by [affiliation] xxxxxxxxxxxxxxxxxxxxxx

  ----analyst each are the 

  select distinct[affiliation], [mostFrequentCurrency], [channelId]
  FROM [projecthololive].[dbo].[Table_for_analyst_SC]
  where [affiliation] = 'CyberLive'


 
