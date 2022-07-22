from __future__ import print_function
import os
import sys
import json
import pandas as pd


def build_msvd_annotation(opt):
    '''
    Follow the format of MSR-VTT dataset,create a json file including video
    info and caption annotations for MSVD. The reason why we need it similar to
    MSR-VTT format, is that we share one `prepare captions' code for all datasets
    '''
    # Firstly, get the name of each video according to the offical csv file
    video_data = pd.read_csv(opt.msvd_csv_path, sep=',', encoding='utf8')
    video_data = video_data[video_data['Language'] == 'English']
    # Only use videos with clean description
    # Fail, some videos does not have clean descriptions
    # video_data = video_data[video_data['Source'] == 'clean']
    video_data['VideoName'] = video_data.apply(lambda row: row['VideoID'] + '_' +
                                               str(row['Start']) + '_' +
                                               str(row['End']), axis=1)
    # Create the dictionary according to the mapping from video name to video_id provided by youtubeclips
    video_name2id = {}
    video_name2split = {}
    root_dir = os.getcwd()
    # if not os.path.exists(root_dir +'/datasets/MSVD/youtube_videos_id'):
    #     os.makedirs(root_dir +'/datasets/MSVD/youtube_videos_id')

    videos = []

    with open(opt.msvd_video_name2id_map, 'r') as f:
        lines = f.readlines()
        for line in lines:
            name, vid = line.strip().split()
            # Extract video's digital id
            # Sub 1 is that the id starts from 1, but we start from 0 in post-processing
            # In practice, we process with sequential info, so sub 1 has no influence
            vid = int(vid[3:]) - 1
            if vid < 1200:
                video_name2split[name] = 'train'
            elif vid < 1200 + 100:
                video_name2split[name] = 'validate'
            else:
                video_name2split[name] = 'test'

            v = {'video_id': 'video%d' % vid, 'split': video_name2split[name], 'id': vid}
            videos.append(v)
            # Transform vid to video+num_id format
            # Do not ask why, because MSR-VTT do like that, stupid!
            vid = 'video%d' % vid
            video_name2id[name] = vid
            # raw_video_name = root_dir + '/datasets/MSVD/youtube_videos' + '/' + name + '.avi'
            # id_video_name = root_dir +'/datasets/MSVD/youtube_videos_id' + '/' + vid + '.avi'
            # os.system('ln -s '+ ' '+raw_video_name + ' '+id_video_name)


    # Create json file according to MSR-VTT data structure
    train_sents_anno = []
    val_sents_anno = []
    test_sents_anno = []
    not_use_video = []
    for sen_id, (name, desc) in enumerate(zip(video_data['VideoName'], video_data['Description'])):
        if name not in video_name2id:
            if name not in not_use_video:
                print('Add: %s' % name)
                not_use_video.append(name)
            not_use_video.append(name)
            continue
        # Be careful, one caption in the video:SKhmFSV-XB0 is NaN
        if type(desc) == float:
            print('Error annotation: %s\t%s' % (name, desc))
            continue
        d = {}
        # Then we filter all non-ascii character!
        desc = desc.encode('ascii', 'ignore').decode('ascii')
        # There are still many problems, some captions have a heap of '\n' or '\r\n'
        desc = desc.replace('\n', '')
        desc = desc.replace('\r', '')
        # Some captions are ended by period, while some does not have period
        # or even have multiple periods.
        # So we filter the period ('.') and the content exceeds one sentence
        # Note that the captions in MSR-VTT data set are not ended by period
        desc = desc.split('.')[0]

        d['caption'] = desc
        d['video_id'] = video_name2id[name]
        d['sen_id'] = sen_id
        if video_name2split[name] == "train":
            train_sents_anno.append(d)
        elif video_name2split[name] == "validate":
            val_sents_anno.append(d)
        else:
            test_sents_anno.append(d)

    train_anno = {'info': {'contributor': 'MSVD', 'version': '1.0'}, 'videos': videos, 'sentences': train_sents_anno}
    val_anno = {'info': {'contributor': 'MSVD', 'version': '1.0'}, 'videos': videos, 'sentences': val_sents_anno}
    test_anno = {'info': {'contributor': 'MSVD', 'version': '1.0'}, 'videos': videos, 'sentences': test_sents_anno}
    with open(opt.msvd_train_anno_json_path, 'w') as f:
        json.dump(train_anno, f)
    with open(opt.msvd_val_anno_json_path, 'w') as f:
        json.dump(val_anno, f)
    with open(opt.msvd_test_anno_json_path, 'w') as f:
        json.dump(test_anno, f)


