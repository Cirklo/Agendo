--
-- Constraints for dumped tables
--


--
-- Constraints for table `allowedips`
--
ALTER TABLE `allowedips`
  ADD CONSTRAINT `allowedips_ibfk_1` FOREIGN KEY (`allowedips_institute`) REFERENCES `institute` (`institute_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `entry`
--
ALTER TABLE `entry`
  ADD CONSTRAINT `entry_ibfk_10` FOREIGN KEY (`entry_user`) REFERENCES `user` (`user_id`),
  ADD CONSTRAINT `entry_ibfk_11` FOREIGN KEY (`entry_repeat`) REFERENCES `repetition` (`repetition_id`),
  ADD CONSTRAINT `entry_ibfk_12` FOREIGN KEY (`entry_status`) REFERENCES `status` (`status_id`),
  ADD CONSTRAINT `entry_ibfk_13` FOREIGN KEY (`entry_resource`) REFERENCES `resource` (`resource_id`);

--
-- Constraints for table `equip`
--
ALTER TABLE `equip`
  ADD CONSTRAINT `equip_ibfk_14` FOREIGN KEY (`equip_resourceid`) REFERENCES `resource` (`resource_id`),
  ADD CONSTRAINT `equip_ibfk_15` FOREIGN KEY (`equip_boardID`) REFERENCES `board` (`board_id`),
  ADD CONSTRAINT `equip_ibfk_16` FOREIGN KEY (`equip_para`) REFERENCES `parameter` (`parameter_id`),
  ADD CONSTRAINT `equip_ibfk_17` FOREIGN KEY (`equip_user`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `measure`
--
ALTER TABLE `measure`
  ADD CONSTRAINT `measure_ibfk_1` FOREIGN KEY (`measure_equip`) REFERENCES `equip` (`equip_id`);

--
-- Constraints for table `permissions`
--
ALTER TABLE `permissions`
  ADD CONSTRAINT `permissions_ibfk_4` FOREIGN KEY (`permissions_user`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `permissions_ibfk_5` FOREIGN KEY (`permissions_resource`) REFERENCES `resource` (`resource_id`),
  ADD CONSTRAINT `permissions_ibfk_6` FOREIGN KEY (`permissions_level`) REFERENCES `permlevel` (`permlevel_id`);

--
-- Constraints for table `resinterface`
--
ALTER TABLE `resinterface`
  ADD CONSTRAINT `resinterface_ibfk_1` FOREIGN KEY (`resinterface_resource`) REFERENCES `resource` (`resource_id`);

--
-- Constraints for table `resource`
--
ALTER TABLE `resource`
  ADD CONSTRAINT `resource_ibfk_10` FOREIGN KEY (`resource_resp`) REFERENCES `user` (`user_id`),
  ADD CONSTRAINT `resource_ibfk_11` FOREIGN KEY (`resource_color`) REFERENCES `color` (`color_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `resource_ibfk_12` FOREIGN KEY (`resource_type`) REFERENCES `resourcetype` (`resourcetype_id`),
  ADD CONSTRAINT `resource_ibfk_9` FOREIGN KEY (`resource_status`) REFERENCES `resstatus` (`resstatus_id`);

--
-- Constraints for table `restree`
--
ALTER TABLE `restree`
  ADD CONSTRAINT `restree_ibfk_1` FOREIGN KEY (`restree_user`) REFERENCES `user` (`user_id`),
  ADD CONSTRAINT `restree_ibfk_2` FOREIGN KEY (`restree_name`) REFERENCES `treeview` (`treeview_id`),
  ADD CONSTRAINT `restree_ibfk_3` FOREIGN KEY (`restree_access`) REFERENCES `access` (`access_id`);

--
-- Constraints for table `resxfields`
--
ALTER TABLE `resxfields`
  ADD CONSTRAINT `resxfields_ibfk_2` FOREIGN KEY (`resxfields_resource`) REFERENCES `resource` (`resource_id`),
  ADD CONSTRAINT `resxfields_ibfk_3` FOREIGN KEY (`resxfields_field`) REFERENCES `xfields` (`xfields_id`);

--
-- Constraints for table `similarresources`
--
ALTER TABLE `similarresources`
  ADD CONSTRAINT `similarresources_ibfk_1` FOREIGN KEY (`similarresources_resource`) REFERENCES `resource` (`resource_id`),
  ADD CONSTRAINT `similarresources_ibfk_2` FOREIGN KEY (`similarresources_similar`) REFERENCES `resource` (`resource_id`);

--
-- Constraints for table `xfields`
--
ALTER TABLE `xfields`
  ADD CONSTRAINT `xfields_ibfk_1` FOREIGN KEY (`xfields_type`) REFERENCES `xfieldsinputtype` (`xfieldsinputtype_id`);

--
-- Constraints for table `xfieldsval`
--
ALTER TABLE `xfieldsval`
  ADD CONSTRAINT `xfieldsval_ibfk_2` FOREIGN KEY (`xfieldsval_field`) REFERENCES `xfields` (`xfields_id`),
  ADD CONSTRAINT `xfieldsval_ibfk_3` FOREIGN KEY (`xfieldsval_entry`) REFERENCES `entry` (`entry_id`) ON DELETE CASCADE;
