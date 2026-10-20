/* frag_8f1908 @ 0x8f1908, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: STREAM_MGR__ready_for_modify
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, bitmap__alloc_bit, bitmap__any_free, bitmap__init, get_g_800242, mid_list__by_mid, mid_list__count_active, scan_resume
 */
	.section .text.frag_8f1908,"ax",@progbits
	.global frag_8f1908
frag_8f1908:
	.global L_8f1908
L_8f1908:
	push_s blink
L_8f190a:
	bl L_8c02c4
L_8f190e:
	bl.d L_8ca258
L_8f1912:
	sub_s sp,sp,0x4
L_8f1914:
	mov_s r1,r0
L_8f1916:
	mov_s r13,sp
L_8f1918:
	bl.d L_8e1140
L_8f191c:
	mov_s r0,r13
L_8f191e:
	b_s L_8f1932
	.global L_8f1920
L_8f1920:
	bl.d L_8db194
L_8f1924:
	mov_s r0,r13
L_8f1926:
	bl L_8ca1b0
L_8f192a:
	bl.d L_8c9798
L_8f192e:
	mov_s r14,r0
L_8f1930:
	brne_s r0,0,L_8f1940
	.global L_8f1932
L_8f1932:
	bl.d L_8cb680
L_8f1936:
	mov_s r0,r13
L_8f1938:
	brne_s r0,0,L_8f1920
L_8f193a:
	b.d L_8c0334
L_8f193e:
	add_s sp,sp,0x4
	.global L_8f1940
L_8f1940:
	mov_s r0,r14
L_8f1942:
	bl.d L_8f00d4
L_8f1946:
	add r0,r0,0x234
L_8f194a:
	b_s L_8f1932
