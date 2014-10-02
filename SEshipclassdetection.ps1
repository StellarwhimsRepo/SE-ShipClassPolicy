    $LARGECTL = 72
    $LARGEMTL = 42
    $LARGEUTL = 24
    $LARGECIVTL = 18

    $SMALLCTL = 36
    $SMALLMTL = 24
    $SMALLUTL = 18
    $SMALLCIVTL = 12

    $LARGEUTOOL = 15
    $LARGEMTOOL = 6

    $SMALLUTOOL = 15
    $SMALLMTOOL = 6

    $LARGEUPROD = 6
    $LARGEMPROD = 3
    $LARGECPROD = 0
        
    $LARGECIVPROD = 4

    $LARGEINTTUR = 10

    $LARGECTUR = 15
    $LARGEMTUR = 8
    $LARGECDF = 10
    $LARGEMDF = 5

    $SMALLCDF = 10
    $SMALLMDF = 5
    
    $total=0    
    $deleted=0
    $civiliancount=0
    $combatcount=0
    $Multirolecount=0
    $utilitycount=0
    
    $filePath = 'your save path here\SANDBOX_0_0_0_.sbs'

    #only edit the above values!===============================================
    
    [xml]$myXML = Get-Content $filePath
    $ns = New-Object System.Xml.XmlNamespaceManager($myXML.NameTable)
    $ns.AddNamespace("xsi", "http://www.w3.org/2001/XMLSchema-instance")

    #Ship class detection and compliance enforcement

    #large
    $nodes = $myXML.SelectNodes("//SectorObjects/MyObjectBuilder_EntityBase[IsStatic='false' and GridSizeEnum='Large' and (@xsi:type='MyObjectBuilder_CubeGrid')]"  , $ns)
    
    ForEach($node in $nodes){
        $turretcount = $node.SelectNodes("CubeBlocks/MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_LargeGatlingTurret')] | MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_LargeMissileTurret')] | MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_SmallMissileLauncher')] | MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_SmallMissileLauncherReload')]", $ns)
        $shiptoolscount = $node.SelectNodes("CubeBlocks/MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_ShipWelder')] | MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_ShipGrinder')] | MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_Drill')]", $ns)
            #utility
            IF($turretcount.count -eq 0 -and $shiptoolscount.count -gt 0){
                Write-Host -ForegroundColor Green "Utility Class Detected!!"
                $utilitycount = $utilitycount + 1

                #thrusters section ==================
                $thrusters=$node.SelectNodes("CubeBlocks/MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_Thrust')]" , $ns)
                    IF( $thrusters.count -gt $LARGEUTL){
                      $total=$thrusters.count - $LARGEUTL
                      do{
                          $thrusters=$node.SelectNodes("CubeBlocks/MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_Thrust')]" , $ns)
                          $deletethis=$thrusters | Get-Random
                          $deletethis.ParentNode.Removechild($deletethis)
                          $total=$total - 1
                          $deleted=$deleted + 1
                      }
                      while($total -gt 0)
                    }
                #end thrusters section ==============

                #turrets/tools section ==================
                    IF( $shiptoolscount.count -gt $LARGEUTOOL){
                      $total=$shiptoolscount.count - $LARGEUTOOL
                      do{
                          $shiptoolscount = $node.SelectNodes("CubeBlocks/MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_ShipWelder')] | MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_ShipGrinder')] | MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_Drill')]", $ns)
                          $deletethis=$shiptoolscount | Get-Random
                          $deletethis.ParentNode.Removechild($deletethis)
                          $total=$total - 1
                          $deleted=$deleted + 1
                      }
                      while($total -gt 0)
                    }
                #end turrets/tools section ==============

                #production section ==================
                  #production
                $production=$node.SelectNodes("CubeBlocks/MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_Refinery')] | MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_Assembler')]" , $ns)
                    IF( $production.count -gt $LARGEUPROD){
                      $total=$production.count - $LARGEUPROD
                      do{
                          $production=$node.SelectNodes("CubeBlocks/MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_Refinery')] | MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_Assembler')]" , $ns)
                          $deletethis=$production | Get-Random
                          $deletethis.ParentNode.Removechild($deletethis)
                          $total=$total - 1
                          $deleted=$deleted + 1
                      }
                      while($total -gt 0)
                    }
                #end production section ==============

                #int turret section ==================
                $intturrets=$node.SelectNodes("CubeBlocks/MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_InteriorTurret')]" , $ns)
                    IF( $intturrets.count -gt $LARGEINTTUR){
                      $total=$intturrets.count - $LARGEINTTUR
                      do{
                          $intturrets=$node.SelectNodes("CubeBlocks/MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_InteriorTurret')]" , $ns)
                          $deletethis=$intturrets | Get-Random
                          $deletethis.ParentNode.Removechild($deletethis)
                          $total=$total - 1
                          $deleted=$deleted + 1
                      }
                      while($total -gt 0)
                    }
                #end int turret section ==============


            }
            #combat
            IF($turretcount.count -gt 0 -and $shiptoolscount.count -eq 0){
                Write-Host -ForegroundColor Green "Combat Class Detected!!"
                $combatcount = $combatcount + 1

                #thrusters section ==================
                $thrusters=$node.SelectNodes("CubeBlocks/MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_Thrust')]" , $ns)
                    IF( $thrusters.count -gt $LARGECTL){
                      $total=$thrusters.count - $LARGECTL
                      do{
                          $thrusters=$node.SelectNodes("CubeBlocks/MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_Thrust')]" , $ns)
                          $deletethis=$thrusters | Get-Random
                          $deletethis.ParentNode.Removechild($deletethis)
                          $total=$total - 1
                          $deleted=$deleted + 1
                      }
                      while($total -gt 0)
                    }
                #end thrusters section ==============

                #turrets/tools section ==================
                #turrets
                $turretcount = $node.SelectNodes("CubeBlocks/MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_LargeGatlingTurret')] | MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_LargeMissileTurret')]", $ns)
                    IF( $turretcount.count -gt $LARGECTUR){
                      $total=$turretcount.count - $LARGECTUR
                      do{
                          $turretcount = $node.SelectNodes("CubeBlocks/MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_LargeGatlingTurret')] | MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_LargeMissileTurret')]", $ns)
                          $deletethis=$turretcount | Get-Random
                          $deletethis.ParentNode.Removechild($deletethis)
                          $total=$total - 1
                          $deleted=$deleted + 1
                      }
                      while($total -gt 0)
                    }
                #Direct Fire
                $turretcount = $node.SelectNodes("CubeBlocks/MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_SmallMissileLauncher')] | MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_SmallMissileLauncherReload')]", $ns)
                    IF( $turretcount.count -gt $LARGECDF){
                      $total=$turretcount.count - $LARGECDF
                      do{
                          $turretcount = $node.SelectNodes("CubeBlocksMyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_SmallMissileLauncher')] | MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_SmallMissileLauncherReload')]", $ns)
                          $deletethis=$turretcount | Get-Random
                          $deletethis.ParentNode.Removechild($deletethis)
                          $total=$total - 1
                          $deleted=$deleted + 1
                      }
                      while($total -gt 0)
                    }
                #end turrets/tools section ==============

                #production section ==================
                  #production
                $production=$node.SelectNodes("CubeBlocks/MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_Refinery')] | MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_Assembler')]" , $ns)
                    IF( $production.count -gt $LARGECPROD){
                      $total=$production.count - $LARGECPROD
                      do{
                          $production=$node.SelectNodes("CubeBlocks/MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_Refinery')] | MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_Assembler')]" , $ns)
                          $deletethis=$production | Get-Random
                          $deletethis.ParentNode.Removechild($deletethis)
                          $total=$total - 1
                          $deleted=$deleted + 1
                      }
                      while($total -gt 0)
                    }
                #end production section ==============

                #int turret section ==================
                $intturrets=$node.SelectNodes("CubeBlocks/MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_InteriorTurret')]" , $ns)
                    IF( $intturrets.count -gt $LARGEINTTUR){
                      $total=$intturrets.count - $LARGEINTTUR
                      do{
                          $intturrets=$node.SelectNodes("CubeBlocks/MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_InteriorTurret')]" , $ns)
                          $deletethis=$intturrets | Get-Random
                          $deletethis.ParentNode.Removechild($deletethis)
                          $total=$total - 1
                          $deleted=$deleted + 1
                      }
                      while($total -gt 0)
                    }
                #end int turret section ==============
                
            }
            #civilian
            IF($turretcount.count -eq 0 -and $shiptoolscount.count -eq 0){
                Write-Host -ForegroundColor Green "Civilian Class Detected!!"
                $civiliancount = $civiliancount + 1

                #thrusters section ==================
                $thrusters=$node.SelectNodes("CubeBlocks/MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_Thrust')]" , $ns)
                    IF( $thrusters.count -gt $LARGECIVTL){
                      $total=$thrusters.count - $LARGECIVTL
                      do{
                          $thrusters=$node.SelectNodes("CubeBlocks/MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_Thrust')]" , $ns)
                          $deletethis=$thrusters | Get-Random
                          $deletethis.ParentNode.Removechild($deletethis)
                          $total=$total - 1
                          $deleted=$deleted + 1
                      }
                      while($total -gt 0)
                    }
                #end thrusters section ==============

                #production section ==================
                  #production
                $production=$node.SelectNodes("CubeBlocks/MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_Refinery')] | MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_Assembler')]" , $ns)
                    IF( $production.count -gt $LARGECIVPROD){
                      $total=$production.count - $LARGECIVPROD
                      do{
                          $production=$node.SelectNodes("CubeBlocks/MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_Refinery')] | MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_Assembler')]" , $ns)
                          $deletethis=$production | Get-Random
                          $deletethis.ParentNode.Removechild($deletethis)
                          $total=$total - 1
                          $deleted=$deleted + 1
                      }
                      while($total -gt 0)
                    }
                #end production section ==============

                #int turret section ==================
                $intturrets=$node.SelectNodes("CubeBlocks/MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_InteriorTurret')]" , $ns)
                    IF( $intturrets.count -gt $LARGEINTTUR){
                      $total=$intturrets.count - $LARGEINTTUR
                      do{
                          $intturrets=$node.SelectNodes("CubeBlocks/MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_InteriorTurret')]" , $ns)
                          $deletethis=$intturrets | Get-Random
                          $deletethis.ParentNode.Removechild($deletethis)
                          $total=$total - 1
                          $deleted=$deleted + 1
                      }
                      while($total -gt 0)
                    }
                #end int turret section ==============
                
            }
            #multirole
            IF($turretcount.count -gt 0 -and $shiptoolscount.count -gt 0){
                Write-Host -ForegroundColor Green "Muti-Role Class Detected!!"
                $Multirolecount = $Multirolecount + 1

                #thrusters section ==================
                $thrusters=$node.SelectNodes("CubeBlocks/MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_Thrust')]" , $ns)
                    IF( $thrusters.count -gt $LARGEMTL){
                      $total=$thrusters.count - $LARGEMTL
                      do{
                          $thrusters=$node.SelectNodes("CubeBlocks/MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_Thrust')]" , $ns)
                          $deletethis=$thrusters | Get-Random
                          $deletethis.ParentNode.Removechild($deletethis)
                          $total=$total - 1
                          $deleted=$deleted + 1
                      }
                      while($total -gt 0)
                    }
                #end thrusters section ==============

                #turrets/tools section ==================
                #turrets
                $turretcount = $node.SelectNodes("CubeBlocks/MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_LargeGatlingTurret')] | MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_LargeMissileTurret')]", $ns)
                    IF( $turretcount.count -gt $LARGEMTUR){
                      $total=$turretcount.count - $LARGEMTUR
                      do{
                          $turretcount = $node.SelectNodes("CubeBlocks/MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_LargeGatlingTurret')] | MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_LargeMissileTurret')]", $ns)
                          $deletethis=$turretcount | Get-Random
                          $deletethis.ParentNode.Removechild($deletethis)
                          $total=$total - 1
                          $deleted=$deleted + 1
                      }
                      while($total -gt 0)
                    }

                #Direct Fire
                $turretcount = $node.SelectNodes("CubeBlocks/MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_SmallMissileLauncher')] | MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_SmallMissileLauncherReload')]", $ns)
                    IF( $turretcount.count -gt $LARGEMDF){
                      $total=$turretcount.count - $LARGEMDF
                      do{
                          $turretcount = $node.SelectNodes("CubeBlocksMyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_SmallMissileLauncher')] | MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_SmallMissileLauncherReload')]", $ns)
                          $deletethis=$turretcount | Get-Random
                          $deletethis.ParentNode.Removechild($deletethis)
                          $total=$total - 1
                          $deleted=$deleted + 1
                      }
                      while($total -gt 0)
                    }
                #tools
                    IF( $shiptoolscount.count -gt $LARGEMTOOL){
                      $total=$shiptoolscount.count - $LARGEMTOOL
                      do{
                          $shiptoolscount = $node.SelectNodes("CubeBlocks/MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_ShipWelder')] | MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_ShipGrinder')] | MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_Drill')]", $ns)
                          $deletethis=$shiptoolscount | Get-Random
                          $deletethis.ParentNode.Removechild($deletethis)
                          $total=$total - 1
                          $deleted=$deleted + 1
                      }
                      while($total -gt 0)
                    }
                #end turrets/tools section ==============

                #production section ==================
                  #production
                $production=$node.SelectNodes("CubeBlocks/MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_Refinery')] | MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_Assembler')]" , $ns)
                    IF( $production.count -gt $LARGEMPROD){
                      $total=$production.count - $LARGEMPROD
                      do{
                          $production=$node.SelectNodes("CubeBlocks/MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_Refinery')] | MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_Assembler')]" , $ns)
                          $deletethis=$production | Get-Random
                          $deletethis.ParentNode.Removechild($deletethis)
                          $total=$total - 1
                          $deleted=$deleted + 1
                      }
                      while($total -gt 0)
                    }
                #end production section ==============

                #int turret section ==================
                $intturrets=$node.SelectNodes("CubeBlocks/MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_InteriorTurret')]" , $ns)
                    IF( $intturrets.count -gt $LARGEINTTUR){
                      $total=$intturrets.count - $LARGEINTTUR
                      do{
                          $intturrets=$node.SelectNodes("CubeBlocks/MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_InteriorTurret')]" , $ns)
                          $deletethis=$intturrets | Get-Random
                          $deletethis.ParentNode.Removechild($deletethis)
                          $total=$total - 1
                          $deleted=$deleted + 1
                      }
                      while($total -gt 0)
                    }
                #end int turret section ==============
                
            }
    }

    #small
    $nodes = $myXML.SelectNodes("//SectorObjects/MyObjectBuilder_EntityBase[IsStatic='false' and GridSizeEnum='Small' and (@xsi:type='MyObjectBuilder_CubeGrid')]"  , $ns)
    
    ForEach($node in $nodes){
        $turretcount = $node.SelectNodes("CubeBlocks/MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_LargeGatlingTurret')] | MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_LargeMissileTurret')] | MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_SmallMissileLauncher')] | MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_SmallMissileLauncherReload')]", $ns)
        $shiptoolscount = $node.SelectNodes("CubeBlocks/MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_ShipWelder')] | MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_ShipGrinder')] | MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_Drill')]", $ns)
            #utility
            IF($turretcount.count -eq 0 -and $shiptoolscount.count -gt 0){
                Write-Host -ForegroundColor Green "Utility Class Detected!!"
                $utilitycount = $utilitycount + 1

                #thrusters section ==================
                $thrusters=$node.SelectNodes("CubeBlocks/MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_Thrust')]" , $ns)
                    IF($thrusters.count -gt $SMALLUTL){
                      $total=$thrusters.count - $SMALLUTL
                      do{
                          $thrusters=$node.SelectNodes("CubeBlocks/MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_Thrust')]" , $ns)
                          $deletethis=$thrusters | Get-Random
                          $deletethis.ParentNode.Removechild($deletethis)
                          $total=$total - 1
                          $deleted=$deleted + 1
                      }
                      while($total -gt 0)
                    }
                #end thrusters section ==============

                #turrets/tools section ==================
                #tools
                    IF( $shiptoolscount.count -gt $SMALLUTOOL){
                      $total=$shiptoolscount.count - $SMALLUTOOL
                      do{
                          $shiptoolscount = $node.SelectNodes("CubeBlocks/MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_ShipWelder')] | MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_ShipGrinder')] | MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_Drill')]", $ns)
                          $deletethis=$shiptoolscount | Get-Random
                          $deletethis.ParentNode.Removechild($deletethis)
                          $total=$total - 1
                          $deleted=$deleted + 1
                      }
                      while($total -gt 0)
                    }
                #end turrets/tools section ==============
            }
            #combat
            IF($turretcount.count -gt 0 -and $shiptoolscount.count -eq 0){
                Write-Host -ForegroundColor Green "Combat Class Detected!!"
                $combatcount = $combatcount + 1

                #thrusters section ==================
                $thrusters=$node.SelectNodes("CubeBlocks/MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_Thrust')]" , $ns)
                    IF($thrusters.count -gt $SMALLCTL){
                      $total=$thrusters.count - $SMALLCTL
                      do{
                          $thrusters=$node.SelectNodes("CubeBlocks/MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_Thrust')]" , $ns)
                          $deletethis=$thrusters | Get-Random
                          $deletethis.ParentNode.Removechild($deletethis)
                          $total=$total - 1
                          $deleted=$deleted + 1
                      }
                      while($total -gt 0)
                    }
                #end thrusters section ==============

                #turrets/tools section ==================
                #Direct Fire
                $turretcount = $node.SelectNodes("CubeBlocks/MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_SmallMissileLauncher')] | MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_SmallMissileLauncherReload')]", $ns)
                    IF($turretcount.count -gt $SMALLCDF){
                      $total=$turretcount.count - $SMALLCDF
                      do{
                          $turretcount = $node.SelectNodes("CubeBlocksMyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_SmallMissileLauncher')] | MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_SmallMissileLauncherReload')]", $ns)
                          $deletethis=$turretcount | Get-Random
                          $deletethis.ParentNode.Removechild($deletethis)
                          $total=$total - 1
                          $deleted=$deleted + 1
                      }
                      while($total -gt 0)
                    }
                #end turrets/tools section ==============
                
            }
            #civilian
            IF($turretcount.count -eq 0 -and $shiptoolscount.count -eq 0){
                Write-Host -ForegroundColor Green "Civilian Class Detected!!"
                $civiliancount = $civiliancount + 1

                #thrusters section ==================
                $thrusters=$node.SelectNodes("CubeBlocks/MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_Thrust')]" , $ns)
                    IF($thrusters.count -gt $SMALLCIVTL){
                      $total=$thrusters.count - $SMALLCIVTL
                      do{
                          $thrusters=$node.SelectNodes("CubeBlocks/MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_Thrust')]" , $ns)
                          $deletethis=$thrusters | Get-Random
                          $deletethis.ParentNode.Removechild($deletethis)
                          $total=$total - 1
                          $deleted=$deleted + 1
                      }
                      while($total -gt 0)
                    }
                #end thrusters section ==============
                
            }
            #multirole
            IF($turretcount.count -gt 0 -and $shiptoolscount.count -gt 0){
                Write-Host -ForegroundColor Green "Muti-Role Class Detected!!"
                $Multirolecount = $Multirolecount + 1

                #thrusters section ==================
                $thrusters=$node.SelectNodes("CubeBlocks/MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_Thrust')]" , $ns)
                    IF($thrusters.count -gt $SMALLMTL){
                      $total=$thrusters.count - $SMALLMTL
                      do{
                          $thrusters=$node.SelectNodes("CubeBlocks/MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_Thrust')]" , $ns)
                          $deletethis=$thrusters | Get-Random
                          $deletethis.ParentNode.Removechild($deletethis)
                          $total=$total - 1
                          $deleted=$deleted + 1
                      }
                      while($total -gt 0)
                    }
                #end thrusters section ==============

                #turrets/tools section ==================
                #tools
                    IF( $shiptoolscount.count -gt $SMALLMTOOL){
                      $total=$shiptoolscount.count - $SMALLUTOOL
                      do{
                          $shiptoolscount = $node.SelectNodes("CubeBlocks/MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_ShipWelder')] | MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_ShipGrinder')] | MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_Drill')]", $ns)
                          $deletethis=$shiptoolscount | Get-Random
                          $deletethis.ParentNode.Removechild($deletethis)
                          $total=$total - 1
                          $deleted=$deleted + 1
                      }
                      while($total -gt 0)
                    }

                #Direct Fire
                $turretcount = $node.SelectNodes("CubeBlocks/MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_SmallMissileLauncher')] | MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_SmallMissileLauncherReload')]", $ns)
                    IF($turretcount.count -gt $SMALLMDF){
                      $total=$turretcount.count - $SMALLMDF
                      do{
                          $turretcount = $node.SelectNodes("CubeBlocksMyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_SmallMissileLauncher')] | MyObjectBuilder_CubeBlock[(@xsi:type='MyObjectBuilder_SmallMissileLauncherReload')]", $ns)
                          $deletethis=$turretcount | Get-Random
                          $deletethis.ParentNode.Removechild($deletethis)
                          $total=$total - 1
                          $deleted=$deleted + 1
                      }
                      while($total -gt 0)
                    }
                #end turrets/tools section ==============
                
            }
    }

    
    Write-Host -ForegroundColor Green "="
    Write-Host -ForegroundColor Green "Total Parts Deleted: "$deleted
    Write-Host -ForegroundColor Green "="
    Write-Host -ForegroundColor Green "Civilian Class Detected: "$civiliancount
    Write-Host -ForegroundColor Green "Combat Class Detected: "$combatcount
    Write-Host -ForegroundColor Green "Utility Class Detected: "$utilitycount
    Write-Host -ForegroundColor Green "Multi-Role Class Detected: "$Multirolecount

    $myXML.Save($filePath)
    Write-Host "Press any key to continue ..."

    $x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    
    