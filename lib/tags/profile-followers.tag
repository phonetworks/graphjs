<graphjs-profile-followers class="wallet">
    <div class={'content' + (loaded ? '' : ' loading') + (blocked ? ' blocked' : '')}>
        <p if={list.length <= 0}>This user has no followers.</p>
        <!--
        <p if={list.length > 0}>{list.length + ' Follower' + (list.length > 1 ? 's' : '')}</p>
        -->
        <graphjs-profile-card each={id in list} id={id}></graphjs-profile-card>
        <graphjs-profile-card if={list.length == 0}></graphjs-profile-card>
        <graphjs-profile-card if={list.length == 0}></graphjs-profile-card>
        <graphjs-profile-card if={list.length == 0}></graphjs-profile-card>
        <graphjs-profile-card if={list.length == 0}></graphjs-profile-card>
        <graphjs-profile-card if={list.length == 0}></graphjs-profile-card>
        <graphjs-profile-card if={list.length == 0}></graphjs-profile-card>
        <button if={blocked} onclick={handleBlock} class="blockage">Login to display content</button>
    </div>
    <style type="less">
        @import '../styles/variables.less';
        @import '../styles/mixins.less';
        @import '../styles/options.less';
    </style>
    <script>
        import getFollowers from '../scripts/getFollowers.js';
        import getUser from '../scripts/getUser.js';

        this.id = opts.id;
        this.list = [];
        this.loaded = true;

        this.on('before-mount', function() {
            this.handleUser();
        });

        this.handleContent = () => {
            let self = this;
            getFollowers(self.id, function(response) {
                if(response.success) {
                    self.list = Object.keys(response.followers);
                    if(self.parent.tags.hasOwnProperty('graphjs-profile-header')) {
                        self.parent.tags['graphjs-profile-header'].profile.follower_count = self.list.length;
                        self.parent.tags['graphjs-profile-header'].update();
                    }
                    self.update();
                } else {
                    //Handle error
                }
            });
        }
        this.handleUser = () => {
            let self = this;
            getUser(function(response) {
                if(response.success) {
                    self.userId = response.id;
                    self.update();
                    self.handleContent();
                } else {
                    self.loaded = false;
                    self.blocked = true;
                    self.update();
                    //Handle errors
                }
            });
        }
    </script>
</graphjs-profile-followers>