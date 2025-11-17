# encoding: utf-8

from ckan.common import CKANConfig
import ckan.plugins as plugins
import ckan.plugins.toolkit as toolkit


class DataGovSGThemePlugin(plugins.SingletonPlugin):
    """
    Data.gov.sg Theme Plugin
    
    A modern, clean theme inspired by Singapore's data.gov.sg portal.
    Features:
    - Purple accent color (#6253e8)
    - Clean, modern layout
    - Responsive design
    - Enhanced user experience
    """
    plugins.implements(plugins.IConfigurer)

    def update_config(self, config: CKANConfig):
        """
        Update CKAN configuration with theme settings.
        """
        # Add this plugin's templates dir to CKAN's extra_template_paths
        toolkit.add_template_directory(config, 'templates')

        # Add this plugin's public dir to CKAN's extra_public_paths
        toolkit.add_public_directory(config, 'public')

        # Register this plugin's assets directory with CKAN
        toolkit.add_resource('assets', 'datagovsg_theme')

