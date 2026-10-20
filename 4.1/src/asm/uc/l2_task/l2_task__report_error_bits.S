/* l2_task__report_error_bits @ 0x929974, 600 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   l2_task.c
 * Зовут его: l2_task__entry
 * Зовёт сам: uc_sysassert
 * Глобалы (через gp): 0x800608
 */
	.section .text.l2_task__report_error_bits,"ax",@progbits
	.global l2_task__report_error_bits
l2_task__report_error_bits:
	.global L_929974
L_929974:
	ld_s r0,[gp,0xe0]
L_929976:
	mov_s r2,0x10004d8
L_92997c:
	btst_s r0,0x0
L_92997e:
	mov.ne r0,blink
L_929982:
	mov.ne r1,0x3
L_929986:
	mov.ne r3,0x5f
L_92998e:
	bne.d L_929bc6
L_929992:
	asl.ne r1,r1,0xd
L_929996:
	btst_s r0,0x1
L_929998:
	mov.ne r1,0x6001
L_9299a0:
	mov.ne r3,0x62
L_9299a8:
	bne.d L_929bc6
L_9299ac:
	mov.ne r0,blink
L_9299b0:
	btst_s r0,0x2
L_9299b2:
	mov.ne r1,0x6002
L_9299ba:
	mov.ne r3,0x65
L_9299c2:
	bne.d L_929bc6
L_9299c6:
	mov.ne r0,blink
L_9299ca:
	btst_s r0,0x3
L_9299cc:
	mov.ne r1,0x6003
L_9299d4:
	mov.ne r3,0x68
L_9299dc:
	bne.d L_929bc6
L_9299e0:
	mov.ne r0,blink
L_9299e4:
	btst_s r0,0x5
L_9299e6:
	mov.ne r1,0x6005
L_9299ee:
	mov.ne r3,0x70
L_9299f6:
	mov.ne r0,blink
L_9299fa:
	bne_s L_929bc6
L_9299fc:
	btst_s r0,0x7
L_9299fe:
	mov.ne r1,0x6007
L_929a06:
	mov.ne r3,0x78
L_929a0e:
	mov.ne r0,blink
L_929a12:
	bne_s L_929bc6
L_929a14:
	btst_s r0,0x9
L_929a16:
	mov.ne r1,0x6009
L_929a1e:
	mov.ne r3,0x80
L_929a26:
	mov.ne r0,blink
L_929a2a:
	bne_s L_929bc6
L_929a2c:
	btst_s r0,0xa
L_929a2e:
	mov.ne r1,0x6010
L_929a36:
	mov.ne r3,0x83
L_929a3e:
	mov.ne r0,blink
L_929a42:
	bne_s L_929bc6
L_929a44:
	btst_s r0,0xb
L_929a46:
	mov.ne r1,0x6011
L_929a4e:
	mov.ne r3,0x86
L_929a56:
	mov.ne r0,blink
L_929a5a:
	bne_s L_929bc6
L_929a5c:
	btst_s r0,0xd
L_929a5e:
	mov.ne r1,0x6013
L_929a66:
	mov.ne r3,0x89
L_929a6e:
	mov.ne r0,blink
L_929a72:
	bne_s L_929bc6
L_929a74:
	btst_s r0,0xe
L_929a76:
	mov.ne r1,0x6014
L_929a7e:
	mov.ne r3,0x8c
L_929a86:
	mov.ne r0,blink
L_929a8a:
	bne_s L_929bc6
L_929a8c:
	btst_s r0,0xf
L_929a8e:
	mov.ne r1,0x6015
L_929a96:
	mov.ne r3,0x8f
L_929a9e:
	mov.ne r0,blink
L_929aa2:
	bne_s L_929bc6
L_929aa4:
	btst_s r0,0x10
L_929aa6:
	mov.ne r1,0x6016
L_929aae:
	mov.ne r3,0x92
L_929ab6:
	mov.ne r0,blink
L_929aba:
	bne_s L_929bc6
L_929abc:
	btst_s r0,0x11
L_929abe:
	mov.ne r1,0x6017
L_929ac6:
	mov.ne r3,0x95
L_929ace:
	mov.ne r0,blink
L_929ad2:
	bne_s L_929bc6
L_929ad4:
	btst_s r0,0x12
L_929ad6:
	mov.ne r1,0x6018
L_929ade:
	mov.ne r3,0x98
L_929ae6:
	mov.ne r0,blink
L_929aea:
	bne_s L_929bc6
L_929aec:
	btst_s r0,0x13
L_929aee:
	mov.ne r1,0x6019
L_929af6:
	mov.ne r3,0x9b
L_929afe:
	mov.ne r0,blink
L_929b02:
	bne_s L_929bc6
L_929b04:
	btst_s r0,0x14
L_929b06:
	mov.ne r1,0x6020
L_929b0e:
	mov.ne r3,0x9e
L_929b16:
	mov.ne r0,blink
L_929b1a:
	bne_s L_929bc6
L_929b1c:
	btst_s r0,0x15
L_929b1e:
	mov.ne r1,0x6021
L_929b26:
	mov.ne r3,0xa1
L_929b2e:
	mov.ne r0,blink
L_929b32:
	bne_s L_929bc6
L_929b34:
	btst_s r0,0x16
L_929b36:
	mov.ne r1,0x6022
L_929b3e:
	mov.ne r3,0xa4
L_929b46:
	mov.ne r0,blink
L_929b4a:
	bne_s L_929bc6
L_929b4c:
	btst_s r0,0x17
L_929b4e:
	mov.ne r1,0x6023
L_929b56:
	mov.ne r3,0xa7
L_929b5e:
	mov.ne r0,blink
L_929b62:
	bne_s L_929bc6
L_929b64:
	btst_s r0,0x1a
L_929b66:
	mov.ne r1,0x6026
L_929b6e:
	mov.ne r3,0xaa
L_929b76:
	mov.ne r0,blink
L_929b7a:
	bne_s L_929bc6
L_929b7c:
	btst_s r0,0x1b
L_929b7e:
	mov.ne r1,0x6027
L_929b86:
	mov.ne r3,0xad
L_929b8e:
	mov.ne r0,blink
L_929b92:
	bne_s L_929bc6
L_929b94:
	btst_s r0,0x1c
L_929b96:
	mov.ne r1,0x6028
L_929b9e:
	mov.ne r3,0xb0
L_929ba6:
	mov.ne r0,blink
L_929baa:
	bne_s L_929bc6
L_929bac:
	btst_s r0,0x1d
L_929bae:
	mov_s r0,blink
L_929bb0:
	mov.ne r1,0x6029
L_929bb8:
	mov_s r3,0xb3
L_929bba:
	mov.eq r1,0x26
L_929bbe:
	mov.eq r3,0xb6
	.global L_929bc6
L_929bc6:
	b L_925548
L_929bca:
	nop_s
