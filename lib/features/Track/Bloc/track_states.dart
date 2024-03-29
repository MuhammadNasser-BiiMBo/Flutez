abstract class TrackStates{}

class TrackInitialState extends TrackStates{}

class InitAudioHandlerSuccessState extends TrackStates{}
class ShadowsSuccessState extends TrackStates{}


class GetTrackLinkLoadingState extends TrackStates{}
class GetTrackLinkSuccessState extends TrackStates{}
class GetTrackLinkErrorState extends TrackStates{}

class SetTrackState extends TrackStates{}
class SeekToNextState extends TrackStates{}
class SeekToPrevState extends TrackStates{}
class ChangeLoopModeState extends TrackStates{}
class SetVolumeState extends TrackStates{}