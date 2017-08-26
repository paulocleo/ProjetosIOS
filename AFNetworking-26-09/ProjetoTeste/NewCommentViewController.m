//
//  NewCommentViewController.m
//  ProjetoTeste
//
//  Created by Crystian Leao on 05/08/17.
//  Copyright © 2017 Roadmaps. All rights reserved.
//

#import "NewCommentViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "AppDelegate.h"

@interface NewCommentViewController ()

@end

@implementation NewCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)enviarClick:(id)sender {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSData *imageData = UIImagePNGRepresentation(self.imagemEscolhida);
    
    
    NSDictionary *parameters = @{
       
            @"comment[user]":self.userTxt.text,
            @"comment[content]":self.commentTxt.text
          
        };
    
    [SVProgressHUD show];
    [manager  POST:@"https://teste-aula-ios.herokuapp.com/comments.json"
        parameters:parameters
    constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    [formData appendPartWithFileData:imageData name:@"comment[picture]" fileName:@"imagemdesc" mimeType:@"image/jpeg"]; }
           success:^(AFHTTPRequestOperation *operation, id responseObject) {
               [SVProgressHUD dismiss];
               [self.navigationController popViewControllerAnimated:YES];
           }           failure:^(AFHTTPRequestOperation *operation, NSError *error) {
               [SVProgressHUD dismiss];
               [self.navigationController popViewControllerAnimated:YES];
           }];
}

- (IBAction)cancelarClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)buscarImagem:(id)sender {
    
//    UIView *view = sender;
//    
//    while (![view isKindOfClass:[UITableViewCell class]]) {
//        view = [view superview];
//    }
    
//    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)view];
    
    //self.produtoSelecionado = self.arrayProducts[indexPath.row];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"AViso" message:@"Escolha" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        self.imagePicker =  [[UIImagePickerController alloc] init];
        self.imagePicker.delegate = self;
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:self.imagePicker animated:YES completion:nil];
        
        
    }];
    
    UIAlertAction *galeryAction = [UIAlertAction actionWithTitle:@"Galeria" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.imagePicker =  [[UIImagePickerController alloc] init];
        self.imagePicker.delegate = self;
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:self.imagePicker animated:YES completion:nil];
    }];
    
    [alert addAction:photoAction];
    [alert addAction:galeryAction];
    [self presentViewController:alert animated:YES completion:nil];
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *originalImage, *editedImage, *imageToSave;
    
    // Handle a still image capture
    editedImage = (UIImage *) info[UIImagePickerControllerEditedImage];
    originalImage = (UIImage *) info[UIImagePickerControllerOriginalImage];
    
    if (editedImage) {
        imageToSave = editedImage;
    } else {
        imageToSave = originalImage;
    }
    
    // Save the new image (original or edited) to the Camera Roll
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
        UIImageWriteToSavedPhotosAlbum (imageToSave, nil, nil , nil);
    
    UIImage *image = imageToSave;
    
    self.imagemEscolhida = image;
    
//    NSDictionary *dic = @{@"imagem": image, @"produto": self.produtoSelecionado};
//    [Fotos novaFoto:dic];
    
    [picker.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}


@end
