

#list projects
contrib-list:
	@echo "Listing projects..."


contrib-init:
	@chmod +x .scripts/contrib.sh
	@.scripts/contrib.sh init

#start contributing (PULL)
contrib-start:	
	@make contrib-init 
	@.scripts/contrib.sh start


#end contributing (PUSH)
contrib-end:
