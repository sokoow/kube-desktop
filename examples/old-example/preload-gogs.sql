SET search_path TO gogs;

INSERT INTO public."user" (id, lower_name, name, full_name, email, passwd, login_type, login_source, login_name, type, location, website, rands, salt, created_unix, updated_unix, last_repo_visibility, max_repo_creation, is_active, is_admin, allow_git_hook, allow_import_local, prohibit_login, avatar, avatar_email, use_custom_avatar, num_followers, num_following, num_stars, num_repos, description, num_teams, num_members) VALUES (1, 'gitadmin', 'gitadmin', '', 'admin@mykube.awesome', 'ebdf30efed007cac5ae7249c33725280005b29e3ec25e9908862091d67fed971759f68544761f469965a8b4aa6ccdf475c9d', 0, 0, '', 0, '', '', 'Z2rUizhwkF', 'NEavqST8VS', 1541277125, 1541277125, false, -1, true, true, false, false, false, '460dd1d9e4e69b3062368f344a01ebd6', 'admin@mykube.awesome', false, 0, 0, 0, 0, '', 0, 0);

INSERT INTO public."access_token" (uid, name, sha1) VALUES (1, 'create_examples.sh', 'c11a1bef30173da024c71ed82fcc517b76fb096d');
