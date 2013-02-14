# -*- coding: utf-8 -*-
from docutils import nodes
from docutils.writers.html4css1 import Writer


############# WikiWriter ##############
class WikiWriter(Writer):
    def __init__(self, *args, **kwargs):
        Writer.__init__(self, *args, **kwargs)
        self.unknown_reference_resolvers = [self.wiki_resolver]
        self.nodes = []
    def wiki_resolver(self, node):
        """
            Normally an unknown reference would be an error in an reST document.
            However, this is how new documents are created in the wiki. This
            passes on unknown references to eventually be handled by
            MoinMoin.
        """
        if hasattr(node, 'indirect_reference_name'):
            node['refuri'] = node.indirect_reference_name
        elif (len(node['ids']) != 0):
            # If the node has an id then it's probably an internal link. Let
            # docutils generate an error.
            return False
        elif node.hasattr('name'):
            node['refuri'] = node['name']
        else:
            node['refuri'] = node['refname']
        del node['refname']
        if hasattr(self, 'nodes'):
            node.resolved = 1
            self.nodes.append(node)
            return True
        else:
            return False
    wiki_resolver.priority = 1
